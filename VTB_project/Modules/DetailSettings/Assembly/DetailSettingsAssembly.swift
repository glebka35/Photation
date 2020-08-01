//
//  DetailSettingsAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailSettingsAssembly {
    func createDetailSettingsModule(with title: String)->DetailSettingsView {
        let presenter: DetailSettingsViewOutput & DetailSettingsInteractorOutput = DetailSettingsPresenter(with: title)
        let detailSettingsView = DetailSettingsView()
        let router = DetailSettingsRouter()
        let interactor = DetailSettingsInteractor()

        router.view = detailSettingsView

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = detailSettingsView
        presenter.interactor = interactor

        detailSettingsView.presenter = presenter

        return detailSettingsView
    }
}
