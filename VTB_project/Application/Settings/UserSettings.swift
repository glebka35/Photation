//
//  UserSettings.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class UserSettings {

    static let shared = UserSettings()

    var nativeLanguage: Language = .en
    var foreignLanguage: Language = .ru

    private init() {}
}


