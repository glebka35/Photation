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
            storage.add(imagesWithObjects: [
                ObjectsOnImage(image: UIImage(named: "car")!.jpegData(compressionQuality: 1)!, objects: [SingleObject(nativeName: "машина", foreignName: "car", color: .black, isFavorite: .no), SingleObject(nativeName: "дерево", foreignName: "tree", color: .yellow, isFavorite: .no), SingleObject(nativeName: "медведь", foreignName: "bear", color: .green, isFavorite: .yes)], nativeLanguage: .ru, foreignLanguage: .en)])
        }
    }
    
    func getObjects() {
        presenter?.objectsDidFetch(objects: storage.objectsOnImages)
    }

    func loadMoreObjects(completion: @escaping () -> Void) {
        // Add core data
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
             (1...10).forEach { _ in
                self?.storage.add(imagesWithObjects: [
                           ObjectsOnImage(image: UIImage(named: "car")!.jpegData(compressionQuality: 1)!, objects: [SingleObject(nativeName: "машина", foreignName: "car", color: .black, isFavorite: .no), SingleObject(nativeName: "дерево", foreignName: "tree", color: .yellow, isFavorite: .no), SingleObject(nativeName: "медведь", foreignName: "bear", color: .green, isFavorite: .yes)], nativeLanguage: .ru, foreignLanguage: .en)])
                   }
            DispatchQueue.main.async {
                completion()
                if let objects = self?.storage.objectsOnImages {
                    self?.presenter?.objectsDidFetch(objects: objects)
                }
            }

        }
    }
}
