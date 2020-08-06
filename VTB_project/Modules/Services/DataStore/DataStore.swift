//
//  DataStore.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

protocol DataStoreProtocol {
    func save(imageWithObjects: ObjectsOnImage)
    func loadMoreImages(page: Int)->[ObjectsOnImage]?
}
