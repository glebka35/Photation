//
//  CollectionPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class CollectionPresenter: CollectionViewOutput {
    var interactor: CollectionInteractorInput?
    weak var view: CollectionViewInput?
    var router: CollectionRouterInput?

    private var displayingObjects: [ObjectsOnImage]?
    private var currentStyle: PresentationStyle!
    private var loadMoreStatus = false
    
    func viewDidLoad(with style: PresentationStyle) {
        currentStyle = style
        interactor?.getObjects()
    }
    
    func changePresentation() {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: currentStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        let newStyle = allCases[nextIndex]
        currentStyle = newStyle
        interactor?.getObjects()
        view?.updatePresentation(with: newStyle)
    }

    func cellSelected(at indexPath: IndexPath) {
        if let object = displayingObjects?[indexPath.row] {
            router?.showDetail(of: object)
        }
    }

    func scrollViewDidScrollToBottom() {
        if !loadMoreStatus {
            loadMoreStatus = true
            loadMoreObjects()
        }
    }

    private func loadMoreObjects() {
        interactor?.loadMoreObjects { [weak self] in
            self?.loadMoreStatus = false
        }
    }
}

extension CollectionPresenter: CollectionInteractorOutput {
    func objectsDidFetch(objects: [ObjectsOnImage]) {
        var objectsToDisplay = [ObjectsOnImage]()
        
        switch(currentStyle) {
        case .images:
            objectsToDisplay = objects
            displayingObjects = objectsToDisplay
        case .table:
            var singleObjects = [SingleObject]()
            var displayingObjects = [ObjectsOnImage]()
            objects.forEach { objectWithImage in
                singleObjects.append(contentsOf: objectWithImage.objects)
                objectWithImage.objects.forEach { _ in
                    displayingObjects.append(objectWithImage)
                }
            }
            if let nativeLanguage = objects.first?.nativeLanguage, let foreignLanguage = objects.first?.foreignLanguage {
                singleObjects.forEach { objectsToDisplay.append(ObjectsOnImage(image: Data(), objects: [$0], nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage))}
            }

            self.displayingObjects = displayingObjects
        default:
            break
        }
        
        view?.updateContent(with: objectsToDisplay)
    }
}

