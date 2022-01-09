//
//  RememberViewModel.swift
//  Photation
//
//  Created by Gleb Uvarkin on 26.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

struct RememberViewModel {
    let navigationBarModel: DefaultNavigationBarModel

    let gameModel: RememberGameModel
    let footerModel: FooterModel
}

struct RememberGameModel {
    var mainWord: String
    var variants: [String]
}

struct FooterModel {
    var currentIndex: Int
    var amount: Int
}

