//
//  DetailSettingsViewModel.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

struct DetailSettingsViewModel {
    let navBarModel: DefaultNavigationBarModel

    var cellModels: [LanguageCellViewModel]
}

struct LanguageCellViewModel {
    let main: String
    let additional: String

    var isChosen: Bool
    var translationCount: Int
}

