//
//  DetailSettingsRouter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailSettingsRouter: DetailSettingsRouterInput {
    weak var view: DetailSettingsView?

    func closeModule() {
        view?.navigationController?.popViewController(animated: true)
    }
}
