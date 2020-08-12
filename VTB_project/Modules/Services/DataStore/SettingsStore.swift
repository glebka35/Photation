//
//  SettingsStore.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 12.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class SettingsStore {

//    MARK: - Constants

    enum Constants {
        static let nativeLanguageKey = "nativeLanguage"
        static let foreignLanguageKey = "foreignLanguage"
    }

//    MARK: - Shared instance

    static let shared = SettingsStore()

//    MARK: - Init

    private init() {}

//    MARK: - Fetching languages

    func getNativeLanguage()->Language {
        let languageString = UserDefaults.standard.string(forKey: Constants.nativeLanguageKey)

        if let savingLanguageString = languageString, let language = Language(rawValue: savingLanguageString) {
            return language
        }

        if let localeLanguageString = Locale.current.languageCode, let language = Language(rawValue: localeLanguageString){
            return language
        }

        return Language.en
    }

    func getForeignLanguage()->Language {
        if let languageString = UserDefaults.standard.string(forKey: Constants.foreignLanguageKey), let language = Language(rawValue: languageString)  {
            return language
        }
        return Language.en
    }

//    MARK: - Saving languages

    func saveNative(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: Constants.nativeLanguageKey)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalConstants.languageChanged), object: nil)
    }

    func saveForeign(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: Constants.foreignLanguageKey)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalConstants.languageChanged), object: nil)
    }
}
