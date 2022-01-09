//
//  DataStore.swift
//  Photation
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {
    func save(imageWithObjects: ObjectsOnImage)
    func loadMoreImages(page: Int, with predicates: [String:String])->[ObjectsOnImage]?
   func loadFavoriteImages(page: Int, with predicates: [String:String])->(objects: [SingleObject]?, images: [ObjectsOnImage]?)
     func imagesCountFor(predicates: [String:String]) -> Int

    func deleteEntities(with predicates: [String:String])
    func updateEntity(with object: SingleObject)
}
