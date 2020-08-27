//
//  Languages.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//let urlString = Bundle.main.path(forResource: "Languages", ofType: "plist")
//
//let data = Data(contentsOf: URL(string: urlString!)!)

enum Language: String, CaseIterable, Decodable {
    case ru, en, es, fr, pt, it, de, nl, ja, ko, vi, sv, da, fi, nb, tr, el, id, ms, th, hi, hu, pl, cs, sk, uk, ca, ro, hr

    var humanRepresentingNative: String {
        switch (self) {
        case .ru:
            return "Русский"
        case .en:
            return "English"
        case .es:
            return "Español"
        case .fr:
            return "Français"
        case .pt:
            return "Português"
        case .it:
            return "Italiano"
        case .de:
            return "Deutsche"
        case .nl:
            return "Nederlands"
        case .ja:
            return "日本人"
        case .ko:
            return "한국어"
        case .vi:
            return "Tiếng Việt,"
        case .sv:
            return "Svenska"
        case .da:
            return "Dansk"
        case .fi:
            return "Suomalainen"
        case .nb:
            return "Norsk"
        case .tr:
            return "Türk"
        case .el:
            return "Ελληνικά"
        case .id:
            return "Indonesian"
        case .ms:
            return "Malay"
        case .th:
            return "ภาษาไทย"
        case .hi:
            return "हिन्दी"
        case .hu:
            return "Magyar"
        case .pl:
            return "Polski"
        case .cs:
            return "Czech"
        case .sk:
            return "Slovenský"
        case .uk:
            return "Українська"
        case .ca:
            return "Català"
        case .ro:
            return "Romanian"
        case .hr:
            return "Hrvatski"
        }
    }

    var humanRepresentingEnglish: String {
        switch (self) {
        case .ru:
            return "Russian"
        case .en:
            return "English"
        case .es:
            return "Spanish"
        case .fr:
            return "French"
        case .pt:
            return "Portuguese"
        case .it:
            return "Italian"
        case .de:
            return "German"
        case .nl:
            return "Dutch"
        case .ja:
            return "Japanese"
        case .ko:
            return "Korean"
        case .vi:
            return "Vietnamese"
        case .sv:
            return "Swedish"
        case .da:
            return "Danish"
        case .fi:
            return "Finnish"
        case .nb:
            return "Norwegian"
        case .tr:
            return "Turkish"
        case .el:
            return "Greek"
        case .id:
            return "Indonesian"
        case .ms:
            return "Malay"
        case .th:
            return "Thai"
        case .hi:
            return "Hindi"
        case .hu:
            return "Hungarian"
        case .pl:
            return "Polish"
        case .cs:
            return "Czech"
        case .sk:
            return "Slovak"
        case .uk:
            return "Ukrainian"
        case .ca:
            return "Catalan"
        case .ro:
            return "Romanian"
        case .hr:
            return "Croatian"
        }

    }
}

