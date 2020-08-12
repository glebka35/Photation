//
//  DetailSettingsInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailSettingsInteractor: DetailSettingsInteractorInput {
//    MARK: - Properties

    weak var presenter: DetailSettingsInteractorOutput?

//    MARK: - Life cycle

    func viewDidLoad() {
        let languages = Language.allCases
        presenter?.display(languages: languages)
    }

//    MARK: - Saving
}
