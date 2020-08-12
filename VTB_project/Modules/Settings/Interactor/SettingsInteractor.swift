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

    //    MARK: - LifeCycle

    func viewDidLoad() {
        let settings: [[SettingsList]] = [[SettingsList.mainLanguage, SettingsList.foreignLanguage], [SettingsList.deleteData]]
        presenter?.display(settings: settings)
    }

    //    MARK: - Data deletion

    func deleteData() {
        let nativeLanguage = SettingsStore.shared.getNativeLanguage()
        let foreignLanguage = SettingsStore.shared.getForeignLanguage()
        let coreDataManager = CoreDataStore.shared

        DispatchQueue.global(qos: .userInitiated).async {
            coreDataManager.deleteEntities(with: nativeLanguage, and: foreignLanguage)
        }

        
    }
}
