//
//  Object.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 08.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

struct Storage {
    public mutating func add(imagesWithObjects: [ObjectsOnImage]) {
        objectsOnImages.append(contentsOf: imagesWithObjects)
    }
    
    private(set) var objectsOnImages: [ObjectsOnImage] = []
}

struct ObjectsOnImage {
    var image: Data?
    var objects: [SingleObject]
    
    var nativeLanguage: String?
    var foreignLanguage: String?
}

struct SingleObject {
    var nativeName: String
    var foreignName: String?

    var color: UIColor
    var isFavorite: IsWordFavorite

    mutating func setForeignName(name: String) {
        self.foreignName = name
    }
}
