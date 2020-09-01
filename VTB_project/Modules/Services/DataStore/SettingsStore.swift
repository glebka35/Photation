//
//  SettingsStore.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 12.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//    MARK: - Constants

enum ConstantsKeys {
    static let nativeLanguage = "nativeLanguage"
    static let foreignLanguage = "foreignLanguage"
}

class SettingsStore {

//    MARK: - Shared instance

    static let shared = SettingsStore()

//    MARK: - Init

    private init() {}

//    MARK: - Fetching languages

    func getNativeLanguage()->Language {

        if let savingLanguageString = UserDefaults.standard.string(forKey: ConstantsKeys.nativeLanguage), let language = Language(rawValue: savingLanguageString) {
            return language
        }

        if let localeLanguageString = Locale.current.languageCode, let language = Language(rawValue: localeLanguageString){
            return language
        }

        return Language.en
    }

    func getForeignLanguage()->Language {
        if let languageString = UserDefaults.standard.string(forKey: ConstantsKeys.foreignLanguage), let language = Language(rawValue: languageString)  {
            return language
        }
        return Language.en
    }

//    MARK: - Saving languages

    func saveNative(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: ConstantsKeys.nativeLanguage)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificionIdentifier.languageChanged), object: nil)
    }

    func saveForeign(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: ConstantsKeys.foreignLanguage)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificionIdentifier.languageChanged), object: nil)
    }
}
