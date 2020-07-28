//
//  Languages.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

enum Language: String {
    case ru, en, es, fr, pt, it, de, nl, ja, ko, vi, sv, da, fi, nb, tr, el, id, ms, th, hi, hu, pl, cs, sk, uk, ca, ro, hr

    var humanRepresenting: String {
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
            return "tiếng Việt,"
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
    
}
