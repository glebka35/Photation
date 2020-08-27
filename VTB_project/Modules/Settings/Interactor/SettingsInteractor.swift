//
//  SettingsInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInput {

    //    MARK: - Properties

    weak var presenter: SettingsInteractorOutput?
    private let settings: [[SettingsList]] = [[SettingsList.mainLanguage, SettingsList.foreignLanguage], [SettingsList.deleteData]]

    //    MARK: - LifeCycle

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: NSNotification.Name(GlobalConstants.languageChanged), object: nil)
    }

    func viewDidLoad() {
        update()

    }

    //    MARK: - Data update

    func deleteData() {
        let nativeLanguage = SettingsStore.shared.getNativeLanguage()
        let foreignLanguage = SettingsStore.shared.getForeignLanguage()
        let coreDataManager = CoreDataStore.shared

        DispatchQueue.global(qos: .userInitiated).async {
            coreDataManager.deleteEntities(with: nativeLanguage, and: foreignLanguage)
        }
    }

    @objc private func languageChanged() {
        update()
    }

    private func update() {
        let navBarModel = MainNavigationBarModel(title: LocalizedString().settings)
        presenter?.display(settings: settings, with: navBarModel)
    }
}
