//
//  DataConverter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit
import CoreData

//MARK: - CoreDataObjectConverterProtocol

protocol CoreDataObjectConverterProtocol {
    var context: NSManagedObjectContext { get }

    func convert(managedObject: [ImageEntity])->[ObjectsOnImage]?
    func convert(imageWithObjects: ObjectsOnImage)->ImageEntity?
}

//MARK: - CoreDataObjectConverter

struct CoreDataObjectConverter: CoreDataObjectConverterProtocol {

    //    MARK: -  Properties

    let context: NSManagedObjectContext

    //    MARK: - Convert from coreData

    func convert(managedObject: [ImageEntity]) -> [ObjectsOnImage]? {
        var imageWithObjects: [ObjectsOnImage] = []

        managedObject.forEach() { image in
            var singleObjects: [SingleObject] = []
            if let objects = image.object as? Set<ObjectEntity> {
                objects.forEach() {
                    if let nativeName = $0.nativeForm, let foreignName = $0.foreignForm, let color = UIColor(hex: $0.color) {
                        singleObjects.append(SingleObject(nativeName: nativeName, foreignName: foreignName, color: color, isFavorite: $0.isFavorite ? .yes : .no))
                    }
                }
            }
            if  let nativeLanguageString = image.nativeLanguage,
                let nativeLanguage = Language(rawValue: nativeLanguageString),
                let foreignLanguageString = image.foreignLanguage,
                let foreignLanguage = Language(rawValue: foreignLanguageString) {

                imageWithObjects.append(ObjectsOnImage(image: image.image, objects: singleObjects, nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage))
            }
        }
        return imageWithObjects
    }

    //    MARK: - Convert to coreData

    func convert(imageWithObjects: ObjectsOnImage) -> ImageEntity? {
        let managedObjectImage = ImageEntity(context: context)
        managedObjectImage.date = Date()
        managedObjectImage.image = imageWithObjects.image
        managedObjectImage.nativeLanguage = imageWithObjects.nativeLanguage.rawValue
        managedObjectImage.foreignLanguage = imageWithObjects.foreignLanguage.rawValue

        var managedObjects: [ObjectEntity] = []

        imageWithObjects.objects.forEach() {
            let managedObject = ObjectEntity(context: context)
            managedObject.foreignForm = $0.foreignName
            managedObject.nativeForm = $0.nativeName
            managedObject.color = $0.color.toHex
            managedObject.isFavorite = $0.isFavorite == .yes ? true : false

            managedObjects.append(managedObject)
        }

        managedObjectImage.object = NSSet(array: managedObjects)

        return managedObjectImage
    }
}
