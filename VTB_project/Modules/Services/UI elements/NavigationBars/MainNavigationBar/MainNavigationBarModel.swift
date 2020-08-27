//
//  MainNavigationBarModel.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 25.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

struct MainNavigationBarModel {
    let title: String
    let additionalTitle: String
    let buttonTitle: String

    init(title: String, additionalTitle: String = "", buttonTitle: String = "") {
        self.title = title
        self.additionalTitle = additionalTitle
        self.buttonTitle = buttonTitle
    }
}
