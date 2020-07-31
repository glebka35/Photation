//
//  SettingsAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class SettingsAssembly {
    func createSettingsModule()->SettingsView {
        let presenter: SettingsViewOutput & SettingsInteractorOutput = SettingsPresenter()
        let settingsView = SettingsView()
        let router = SettingsRouter()
        let interactor = SettingsInteractor()

        router.view = settingsView

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = settingsView
        presenter.interactor = interactor

        settingsView.presenter = presenter

        return settingsView
    }
}
