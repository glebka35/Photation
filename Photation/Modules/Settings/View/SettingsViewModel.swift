//
//  ViewModel.swift
//  Photation
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

struct SettingsViewModel {
    let navigationBarModel: MainNavigationBarModel

    let cellModels: [[SettingsCellViewModel]]
}

struct SettingsCellViewModel {
    let title: String
    let image: UIImage?
}
