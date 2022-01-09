//
//  SettingsRouter.swift
//  Photation
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class SettingsRouter: SettingsRouterInput {
    weak var view: SettingsView?

    func showDetail(with settings: SettingsList) {
        let detailView = DetailSettingsAssembly().createDetailSettingsModule(with: settings)
        view?.navigationController?.pushViewController(detailView, animated: true)
    }

    func closeModeule() {

    }
}
