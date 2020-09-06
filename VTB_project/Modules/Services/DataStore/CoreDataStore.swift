//
//  DataStore.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 01.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit
import CoreData


class CoreDataStore: NSObject, DataStoreProtocol {

    //    MARK: - Constants

    private enum Constants {
        static let pageSize = 20
    }

    //    MARK: - Singleton

    static let shared = CoreDataStore()

    //    MARK: - Properties

    private lazy var converter: CoreDataObjectConverterProtocol = {
        return CoreDataObjectConverter(context: managedContext)
    } ()

    private lazy var fetchRequest: NSFetchRequest<ImageEntity> = {
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)

        fetchRequest.fetchBatchSize = Constants.pageSize
        fetchRequest.sortDescriptors = [sortDescriptor]

        return fetchRequest
    } ()

    private lazy var favoriteFetchRequest: NSFetchRequest<ObjectEntity> = {
        let favoriteFetchRequest: NSFetchRequest<ObjectEntity> = ObjectEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)

        favoriteFetchRequest.fetchBatchSize = Constants.pageSize
        favoriteFetchRequest.sortDescriptors = [sortDescriptor]

        return favoriteFetchRequest
    } ()

    private lazy var managedContext: NSManagedObjectContext = {
        persistentContainer.newBackgroundContext()
    } ()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotationCoreData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Problem with NSPersistentContainer")
            }
        }
        //        Uncomment to get dataStore url
//        print(NSPersistentContainer.defaultDirectoryURL())
        return container
    } ()

    //    MARK: - Life cycle

    private override init() { }

    //    MARK: - Saving

    func save(imageWithObjects: ObjectsOnImage) {
        let manageObject = converter.convert(imageWithObjects: imageWithObjects)
        do {
            try manageObject?.managedObjectContext?.save()
            newImageAdded()
        } catch {
            print("Error while saving")
        }
    }

    private func newImageAdded() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificionIdentifier.newImageAdded), object: nil)
        }
    }

    //    MARK: - Fetching

    func loadMoreImages(page: Int, with predicates: [String:String])->[ObjectsOnImage]? {
        fetchRequest.predicate = configurePredicate(with: predicates)
        fetchRequest.fetchOffset = page * Constants.pageSize
        fetchRequest.fetchBatchSize = Constants.pageSize

        do {
            let objects = try managedContext.fetch(fetchRequest)
            return converter.convert(managedObject: objects)
        } catch {
            print("Fetch failed")
            return nil
        }
    }

    func loadFavoriteImages(page: Int, with predicates: [String:String])->(objects: [SingleObject]?, images: [ObjectsOnImage]?) {
        favoriteFetchRequest.predicate = configurePredicate(with: predicates)
        favoriteFetchRequest.fetchOffset = page * Constants.pageSize
        favoriteFetchRequest.fetchBatchSize = Constants.pageSize

        do {
            let objects = try managedContext.fetch(favoriteFetchRequest)
            return converter.getObjectsAndImages(objects: objects)
        } catch {
            print("Fetch failed")
            return (nil, nil)
        }
    }

    func imagesCountFor(predicates: [String:String]) -> Int {
        fetchRequest.predicate = configurePredicate(with: predicates)
        fetchRequest.fetchOffset = 0
        fetchRequest.fetchBatchSize = 0

        do {
            let count = try managedContext.count(for: fetchRequest)
            return count
        } catch {
            fatalError(error.localizedDescription)
        }
    }


    //    MARK: - Fetch request configuration

    private func configurePredicate(with dict: [String:String])->NSCompoundPredicate {
        let nsPredicates = dict.map { (key, value) -> NSPredicate in
            NSPredicate(format: "\(key) == %@", value)
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: nsPredicates)
    }

    //    MARK: - Deleting

    func deleteEntities(with predicates: [String:String]) {
        let deleteFetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        deleteFetchRequest.predicate = configurePredicate(with: predicates)

        do {
            let objects = try managedContext.fetch(deleteFetchRequest)
            objects.forEach() {
                managedContext.delete($0)
            }

            try managedContext.save()

            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(NotificionIdentifier.deletaDataNotification), object: nil)
            }
        } catch {
            fatalError("Error while deleting objects")
        }
    }

    //    MARK: - Update object

    func updateEntity(with object: SingleObject) {
        let updateFetchRequest: NSFetchRequest<ObjectEntity> = ObjectEntity.fetchRequest()
        let datePredicate = NSPredicate(format: "id = %@", object.id)

        updateFetchRequest.predicate = datePredicate

        do {
            let objects = try managedContext.fetch(updateFetchRequest)

            objects.first?.isFavorite = object.isFavorite == .yes ? true : false

            try managedContext.save()

            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(NotificionIdentifier.dataModified), object: nil)
            }
        } catch {
            fatalError("Error while deleting objects")
        }

    }
}
