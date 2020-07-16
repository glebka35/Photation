//
//  Object.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 08.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

public struct Storage {
    public mutating func add(imagesWithObjects: [ObjectsOnImage]) {
        objectsOnImages.append(contentsOf: imagesWithObjects)
    }
    
    private(set) var objectsOnImages = [ObjectsOnImage]()
}

public struct ObjectsOnImage {
    let image: Data
    let objects: [SingleObject]
    
    let nativeLanguage: String
    let foreignLanguage: String
}

public struct SingleObject {
    let nativeName: String
    let foreignName: String
}
