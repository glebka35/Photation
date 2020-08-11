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

    private var displayingObjects: [ObjectsOnImage]?

    //    MARK: - Life cycle

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

    func cellSelected(at indexPath: IndexPath) {
        if let object = displayingObjects?[indexPath.row] {
            router?.showDetail(of: object)
        }
    }

    func scrollViewDidScrollToBottom() {
        interactor?.loadObjects()
    }
}

extension FavoritePresenter: FavoriteInteractorOutput {
    func objectsDidFetch(objects: [ObjectsOnImage]) {
        var objectsToDisplay = [ObjectsOnImage]()
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

        view?.updateContent(with: objectsToDisplay)
    }
}
