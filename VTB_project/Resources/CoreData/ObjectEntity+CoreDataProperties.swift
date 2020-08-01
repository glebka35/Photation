//
//  ObjectEntity+CoreDataProperties.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//
//

import Foundation
import CoreData


extension ObjectEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ObjectEntity> {
        return NSFetchRequest<ObjectEntity>(entityName: "ObjectEntity")
    }

    @NSManaged public var foreignForm: String?
    @NSManaged public var nativeForm: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var toImage: ImageEntity?

}
