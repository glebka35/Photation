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

    func convert(managedObject: [ImageEntity])->[ObjectsOnImage]
    func convert(imageWithObjects: ObjectsOnImage)->ImageEntity?
    func getObjectsAndImages(objects: [ObjectEntity])->(objects: [SingleObject], images: [ObjectsOnImage])
}

//MARK: - CoreDataObjectConverter

struct CoreDataObjectConverter: CoreDataObjectConverterProtocol {

    //    MARK: -  Properties

    let context: NSManagedObjectContext

    //    MARK: - Convert from coreData

    func convert(managedObject: [ImageEntity]) -> [ObjectsOnImage] {
        var imageWithObjects: [ObjectsOnImage] = []

        managedObject.forEach() { image in
            var singleObjects: [SingleObject] = []
            if let objects = image.object as? Set<ObjectEntity> {
                objects.forEach() {
                    if let nativeName = $0.nativeForm, let foreignName = $0.foreignForm, let color = UIColor(hex: $0.color), let id = $0.id {
                        singleObjects.append(SingleObject(nativeName: nativeName, foreignName: foreignName, color: color, isFavorite: $0.isFavorite ? .yes : .no, id: id))
                    }
                }
            }
            if  let nativeLanguageString = image.nativeLanguage,
                let nativeLanguage = Language(rawValue: nativeLanguageString),
                let foreignLanguageString = image.foreignLanguage,
                let foreignLanguage = Language(rawValue: foreignLanguageString),
                let date = image.date {

                imageWithObjects.append(ObjectsOnImage(image: image.image, objects: singleObjects, date: date, nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage))
            }
        }
        return imageWithObjects
    }

    //    MARK: - Convert to coreData

    func convert(imageWithObjects: ObjectsOnImage) -> ImageEntity? {
        let managedObjectImage = ImageEntity(context: context)
        managedObjectImage.date = imageWithObjects.date
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
            managedObject.id = $0.id

            managedObjects.append(managedObject)

        }

        managedObjectImage.object = NSSet(array: managedObjects)

        return managedObjectImage
    }

    func getObjectsAndImages(objects: [ObjectEntity])->(objects: [SingleObject], images: [ObjectsOnImage]) {
        var singleObjects: [SingleObject] = []
        var images: [ImageEntity] = []

        objects.forEach {
            if let nativeName = $0.nativeForm, let foreignName = $0.foreignForm, let color = UIColor(hex: $0.color), let id = $0.id  {
                let isFavorite = $0.isFavorite ? IsWordFavorite.yes : .no

                singleObjects.append(SingleObject(nativeName: nativeName, foreignName: foreignName, color: color, isFavorite: isFavorite, id: id))
            }

            if let image = $0.image {
                images.append(image)
            }
        }

        let objectOnImages = convert(managedObject: images)

        return (objects: singleObjects, images: objectOnImages)
    }
}
