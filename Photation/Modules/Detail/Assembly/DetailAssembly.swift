//
//  DetailAssembly.swift
//  Photation
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailAssembly {
    func createDetailModule(with object: ObjectsOnImage)->DetailView {
        let presenter: DetailViewOutput & DetailInteractorOutput = DetailPresenter(with: object)
        let detailView = DetailView()
        let router = DetailRouter()
        let interactor = DetailInteractor()

        router.view = detailView

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = detailView
        presenter.interactor = interactor

        detailView.presenter = presenter

        return detailView
    }
}
