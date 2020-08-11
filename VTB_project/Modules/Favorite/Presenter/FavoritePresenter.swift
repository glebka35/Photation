//
//  FavoritePresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class FavoritePresenter: NSObject, FavoriteViewOutput {

    //    MARK: - Properties
    
    var interactor: FavoriteInteractorInput?
    weak var view: FavoriteViewInput?
    var router: FavoriteRouterInput?

    private var displayingObjects: [ObjectsOnImage] = []
    private var objectsAndImages: [ObjectsOnImage] = []

    //    MARK: - Life cycle

    func viewDidLoad() {
        displayingObjects = []
        objectsAndImages = []
        interactor?.viewDidLoad()
    }

    func cellSelected(at indexPath: IndexPath) {
        let object = objectsAndImages[indexPath.row]
        router?.showDetail(of: object)
    }

    func scrollViewDidScrollToBottom() {
        interactor?.loadObjects()
    }
}

extension FavoritePresenter: FavoriteInteractorOutput {
    func objectsDidFetch(images: [ObjectsOnImage], objects: [SingleObject]) {
        self.objectsAndImages.append(contentsOf: images)

        var objectsToDisplay: [ObjectsOnImage] = []


        if let nativeLanguage = self.objectsAndImages.first?.nativeLanguage, let foreignLanguage = self.objectsAndImages.first?.foreignLanguage, let date = self.objectsAndImages.first?.date {
            objects.forEach {
                objectsToDisplay.append(ObjectsOnImage(image: Data(), objects: [$0], date: date, nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage))
            }
        }

        displayingObjects.append(contentsOf: objectsToDisplay)
        view?.updateContent(with: objectsToDisplay)
    }

    func deleteData() {
        self.objectsAndImages = []
        self.displayingObjects = []

        view?.updateContent(with: [])
    }
}
