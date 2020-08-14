//
//  DetailSettingsPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - DetailSettingsViewOutput

class DetailSettingsPresenter: DetailSettingsViewOutput {

//    MARK: - Properties

    var interactor: DetailSettingsInteractorInput?
    weak var view: DetailSettingsViewInput?
    var router: DetailSettingsRouterInput?

    private var title: String
    var data: [LanguageCellViewModel] = [] {
        didSet {
            view?.updateTable(with: data)
        }
    }

    private var settings: SettingsList

//    MARK: - Life cycle

    required init(with settings: SettingsList) {
        self.title = LocalizedString().getSettingsString(settings: settings)
        self.settings = settings
    }

    func viewDidLoad() {
        view?.set(title: title)
        interactor?.viewDidLoad()
    }

//    MARK: - User interaction

    func languageChoosen(at indexPath: IndexPath) {
        data = data.map {
            LanguageCellViewModel(main: $0.main, additional: $0.additional, isChosen: false)
        }
        data[indexPath.row].isChosen = true

        interactor?.languageChosen(at: indexPath, settings: settings)
    }

    func backButtonPressed() {
        router?.closeModule()
    }
}

//MARK: - DetailSettingsInteractorOutput

extension DetailSettingsPresenter: DetailSettingsInteractorOutput {
    func display(languages: [Language]) {
        var languagesCellModel: [LanguageCellViewModel] = []

        var currentChosenLanguage = Language.en

        switch settings {
        case .foreignLanguage:
            currentChosenLanguage = SettingsStore.shared.getForeignLanguage()
        case .mainLanguage:
            currentChosenLanguage = SettingsStore.shared.getNativeLanguage()
        default:
            break
        }

        languages.forEach() {
            let isChosen = $0 == currentChosenLanguage
            languagesCellModel.append(LanguageCellViewModel(main: $0.humanRepresentingNative, additional: $0.humanRepresentingEnglish, isChosen: isChosen))
        }

        data = languagesCellModel
    }

    func languageChanged() {
        view?.languageChanged(settings: settings)
    }
}
