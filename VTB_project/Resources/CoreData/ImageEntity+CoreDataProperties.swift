//
//  ImageEntity+CoreDataProperties.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var image: Data?
    @NSManaged public var date: Date?
    @NSManaged public var toObject: NSSet?

}

// MARK: Generated accessors for toObject
extension ImageEntity {

    @objc(addToObjectObject:)
    @NSManaged public func addToToObject(_ value: ObjectEntity)

    @objc(removeToObjectObject:)
    @NSManaged public func removeFromToObject(_ value: ObjectEntity)

    @objc(addToObject:)
    @NSManaged public func addToToObject(_ values: NSSet)

    @objc(removeToObject:)
    @NSManaged public func removeFromToObject(_ values: NSSet)

}
