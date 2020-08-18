//
//  RememberObjects.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

typealias RememberObjects = [SingleObject]

struct RememberGameModel {
    var mainWord: String
    var variants: [String]

    var footerModel: FooterModel
}
