//
//  CollectionViewModel.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 25.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

//MARK: - Model

struct CollectionViewModel {
    let navigationBarModel: MainNavigationBarModel

    let imageModel: ImageStyleCollectionModel?
    let tableModel: TableStyleCollectionModel?
}

//MARK: - Image style

struct ImageStyleCollectionModel {
    let objects: [ImageStyleObject]
}

struct ImageStyleObject {
    let image: UIImage
    let objectName: String

    let id: Date
}

//MARK: - Table style

struct TableStyleCollectionModel {
    let nativeLanguage: String
    let foreignLanguage: String

    let objects: [TableStyleObject]
}

struct TableStyleObject {
    let nativeName: String
    let foreignName: String

    let id: Date
}
