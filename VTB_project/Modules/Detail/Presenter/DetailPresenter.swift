//
//  DetailPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - DetailViewOutput

class DetailPresenter: DetailViewOutput {

//    MARK: - Properties

    var interactor: DetailInteractorInput?
    var view: DetailViewInput?
    var router: DetailRouterInput?

    private var objects: ObjectsOnImage

//    MARK: - Life cycle

    init(with object: ObjectsOnImage) {
        self.objects = object
    }

    func viewDidLoad() {
        view?.configureCollection(with: objects)
    }

//    MARK: - User interaction

    func wordChosen(at index: Int) {
//        objects[index].isFavorite
        let allCases = IsWordFavorite.allCases

        guard let currentIndex = allCases.firstIndex(of: objects.objects[index].isFavorite) else { return }
        let nextIndex = (currentIndex + 1) % allCases.count
        let newFavorite = allCases[nextIndex]
        objects.objects[index].isFavorite = newFavorite

        view?.updateContent(with: objects.objects)
    }

    func backButtonPressed() {
        router?.dismiss()
    }
}

//MARK: - DetailInteractorOutput

extension DetailPresenter: DetailInteractorOutput {
    
}
