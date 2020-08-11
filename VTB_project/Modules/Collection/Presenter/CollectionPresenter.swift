//
//  CollectionPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - CollectionViewOutput

class CollectionPresenter: CollectionViewOutput {

    //    MARK: - Properties

    var interactor: CollectionInteractorInput?
    weak var view: CollectionViewInput?
    var router: CollectionRouterInput?

    private var displayingObjects: [ObjectsOnImage] = []
    private var objects: [ObjectsOnImage] = []
    private var currentStyle: PresentationStyle!

    //    MARK: - UI life cycle
    func viewDidLoad(with style: PresentationStyle) {
        currentStyle = style
        interactor?.loadObjects()
    }

    //    MARK: - UI update
    
    func changePresentation() {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: currentStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        let newStyle = allCases[nextIndex]
        currentStyle = newStyle

        let objectsToDisplay = convertData(objects: self.objects)
        view?.updateContent(with: objectsToDisplay)

        view?.updatePresentation(with: newStyle)
    }

    func cellSelected(at indexPath: IndexPath) {
        let object = displayingObjects[indexPath.row]
        router?.showDetail(of: object)
    }

    func scrollViewDidScrollToBottom() {
            interactor?.loadObjects()
    }
}

//MARK: - CollectionInteractorOutput

extension CollectionPresenter: CollectionInteractorOutput {
    func objectsDidFetch(objects: [ObjectsOnImage]) {
        self.objects.append(contentsOf: objects)
        let objectsToDisplay = convertData(objects: self.objects)
        view?.updateContent(with: objectsToDisplay)
    }

    func deleteData() {
        self.displayingObjects = []
        self.objects = []

        view?.updateContent(with: [])
    }

    //TODO: перенести в отдельный класс DataConverter

    private func convertData(objects: [ObjectsOnImage])->[ObjectsOnImage] {
        var objectsToDisplay = [ObjectsOnImage]()

        switch(currentStyle) {
        case .images:
            objectsToDisplay = objects
            displayingObjects = objectsToDisplay
        case .table:
            var singleObjects = [SingleObject]()
            var displayingObjects = [ObjectsOnImage]()
            self.objects.forEach { objectWithImage in
                singleObjects.append(contentsOf: objectWithImage.objects)
                objectWithImage.objects.forEach { _ in
                    displayingObjects.append(objectWithImage)
                }
            }
            if let nativeLanguage = objects.first?.nativeLanguage, let foreignLanguage = objects.first?.foreignLanguage, let date = objects.first?.date {
                singleObjects.forEach { objectsToDisplay.append(ObjectsOnImage(image: Data(), objects: [$0], date: date, nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage))}
            }

            self.displayingObjects = displayingObjects
        default:
            break
        }

        return objectsToDisplay
    }

}

