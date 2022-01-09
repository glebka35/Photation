//
//  Object.swift
//  Photation
//
//  Created by Gleb Uvarkin on 08.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

struct ObjectsOnImage {
    var image: Data?
    var objects: [SingleObject]
    var date: Date
    
    var nativeLanguage: Language
    var foreignLanguage: Language
}

struct SingleObject {
    var nativeName: String
    var foreignName: String

    var color: UIColor
    var isFavorite: IsWordFavorite
    var id: String
}
