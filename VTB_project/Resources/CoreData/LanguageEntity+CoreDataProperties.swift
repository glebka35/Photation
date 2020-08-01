//
//  LanguageEntity+CoreDataProperties.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//
//

import Foundation
import CoreData


extension LanguageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LanguageEntity> {
        return NSFetchRequest<LanguageEntity>(entityName: "LanguageEntity")
    }

    @NSManaged public var language: String?

}
