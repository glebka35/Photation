//
//  CollectionInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit // Надо убрать отсюда зависимость от UIKit, пока этого нельзя сделать, так как
// вместо картинок использую заглушки из ассетов, но после подключения api эта проблема уйдет

class CollectionInteractor: CollectionInteractorInput {
    weak var presenter: CollectionInteractorOutput?
    var storage = Storage()
    
    init() {
        (1...10).forEach { _ in
            storage.add(imagesWithObjects: [ObjectsOnImage(image: UIImage(named: "car")!.jpegData(compressionQuality: 1)!, objects: [SingleObject(nativeName: "машина", foreignName: "car"), SingleObject(nativeName: "дерево", foreignName: "tree"), SingleObject(nativeName: "медведь", foreignName: "bear")], nativeLanguage: "Русский", foreignLanguage: "Английский")])
        }
    }
    
    func getObjects() {
        presenter?.objectsDidFetch(objects: storage.objectsOnImages)
    }
}
