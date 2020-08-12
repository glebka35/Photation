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
    private let languages = Language.allCases

//    MARK: - Life cycle

    func viewDidLoad() {
        presenter?.display(languages: languages)
    }

//    MARK: - Saving

    func languageChosen(at indexPath: IndexPath, settings: SettingsList) {
        switch settings {
        case .foreignLanguage:
            SettingsStore.shared.saveForeign(language: languages[indexPath.row])
        case.mainLanguage:
            SettingsStore.shared.saveNative(language: languages[indexPath.row])
        default:
            break
        }
    }
}
