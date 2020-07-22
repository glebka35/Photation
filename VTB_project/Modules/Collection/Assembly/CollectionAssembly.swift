//
//  CollectionAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class CollectionAssembly {
    func createCollectionModule()->CollectionView {
        let presenter: CollectionPresenterProtocol & CollectionOutputInteractorProtocol = CollectionPresenter()
        let collectionView = CollectionView()
        let router = CollectionRouter()
        let interactor = CollectionInteractor()

        router.view = collectionView

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = collectionView
        presenter.interactor = interactor

        collectionView.presenter = presenter

        return collectionView
    }
}
