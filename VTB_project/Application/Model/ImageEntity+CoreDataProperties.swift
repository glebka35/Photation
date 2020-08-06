//
//  ImageEntity+CoreDataProperties.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var nativeLanguage: String?
    @NSManaged public var foreignLanguage: String?
    @NSManaged public var object: NSSet?

}

// MARK: Generated accessors for object
extension ImageEntity {

    @objc(addObjectObject:)
    @NSManaged public func addToObject(_ value: ObjectEntity)

    @objc(removeObjectObject:)
    @NSManaged public func removeFromObject(_ value: ObjectEntity)

    @objc(addObject:)
    @NSManaged public func addToObject(_ values: NSSet)

    @objc(removeObject:)
    @NSManaged public func removeFromObject(_ values: NSSet)

}
