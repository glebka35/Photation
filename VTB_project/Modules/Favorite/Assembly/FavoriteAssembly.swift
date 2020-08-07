//
//  FavouriteAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class FavoriteAssembly {
    func createFavoriteModule()->FavoriteView {
        let presenter: FavoriteViewOutput & FavoriteInteractorOutput = FavoritePresenter()
        let favoriteView = FavoriteView()
        let router = FavoriteRouter()
        let interactor = FavoriteInteractor()

        router.view = favoriteView

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = favoriteView
        presenter.interactor = interactor

        favoriteView.presenter = presenter

        return favoriteView
    }
}
