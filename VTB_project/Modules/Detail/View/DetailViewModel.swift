//
//  DetailViewModel.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 25.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

struct DetailViewModel {
    let defaultNavigationBarModel: DefaultNavigationBarModel

    let detailCollectionModel: DetailCollectionModel
}

struct DetailCollectionModel {
    let image: UIImage
    let nativeLanguage: String
    let foreignLanguage: String

    let objects: [SingleObject]
}

