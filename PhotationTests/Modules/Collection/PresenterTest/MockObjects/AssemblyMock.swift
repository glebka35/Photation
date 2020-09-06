//
//  AssemblyMock.swift
//  PhotationTests
//
//  Created by Gleb Uvarkin on 02.09.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
@testable import Photation

class CollectionAssemblyMock: CollectionAssembly {
    override func createCollectionModule() -> CollectionViewMock {
        let presenter: CollectionViewOutput & CollectionInteractorOutput = CollectionPresenter()
        let collectionView = CollectionViewMock()
        let router = CollectionRouterMock()
        let interactor = CollectionInteractorMock()

        router.view = collectionView

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = collectionView
        presenter.interactor = interactor

        collectionView.presenter = presenter

        return collectionView
    }
}
