//
//  DataConverter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit
import CoreData


protocol CoreDataObjectConverterProtocol {
    var nativeLanguage: Language { get }
    var foreignLanguage: Language { get }
    var context: NSManagedObjectContext { get }

    func convert(from managedObject: [ImageEntity])->[ObjectsOnImage]?
    func convert(from imageWithObjects: ObjectsOnImage)->ImageEntity?
}

struct CoreDataObjectConverter: CoreDataObjectConverterProtocol {
    let nativeLanguage: Language
    let foreignLanguage: Language
    let context: NSManagedObjectContext

    func convert(from managedObject: [ImageEntity]) -> [ObjectsOnImage]? {
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
            imageWithObjects.append(ObjectsOnImage(image: image.image, objects: singleObjects, nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage))
        }
        return imageWithObjects
    }

    func convert(from imageWithObjects: ObjectsOnImage) -> ImageEntity? {
        let managedObjectImage = ImageEntity(context: context)
        managedObjectImage.date = Date()
        managedObjectImage.image = imageWithObjects.image

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
