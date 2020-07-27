//
//  DetailAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailAssembly {
    func createDetailModule()->DetailView {
        let presenter: DetailViewOutput & DetailInteractorOutput = DetailPresenter()
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
