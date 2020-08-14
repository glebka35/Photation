//
//  SettingsList.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit


enum SettingsList: CaseIterable {
    case mainLanguage
    case foreignLanguage

    case deleteData

    var image: UIImage? {
        switch self {
        case . mainLanguage:
            return UIImage(named: "world")
        case .foreignLanguage:
            return UIImage(named: "book")
        case .deleteData:
            return nil
        }
    }
}
