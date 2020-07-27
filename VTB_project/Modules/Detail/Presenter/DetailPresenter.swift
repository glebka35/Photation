//
//  DetailPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class DetailPresenter: DetailViewOutput {
    var interactor: DetailInteractorInput?
    var view: DetailViewInput?
    var router: DetailRouterInput?

    var objects: [DetailObject] = [
        DetailObject(singleObject: SingleObject(nativeName: "машина", foreignName: "car"), color: .red, isFavorite: .no),
        DetailObject(singleObject: SingleObject(nativeName: "дом", foreignName: "tree"), color: .green, isFavorite: .yes),
    ]

    func viewDidLoad() {
        view?.configureCollection(with: objects, and: UIImage(named: "car"))
    }

    func wordChosen(at index: Int) {
//        objects[index].isFavorite
        let allCases = IsWordFavorite.allCases

        guard let currentIndex = allCases.firstIndex(of: objects[index].isFavorite) else { return }
        let nextIndex = (currentIndex + 1) % allCases.count
        let newFavorite = allCases[nextIndex]
        objects[index].isFavorite = newFavorite

        view?.updateContent(with: objects)
    }

    func backButtonPressed() {
        router?.dismiss()
    }
}

extension DetailPresenter: DetailInteractorOutput {
    
}
