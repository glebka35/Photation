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
        let managedContext = persistentContainer.newBackgroundContext()
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)

        fetchRequest.fetchBatchSize = Constants.pageSize
        fetchRequest.sortDescriptors = [sortDescriptor]

        return fetchRequest
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
        print(NSPersistentContainer.defaultDirectoryURL())
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalConstants.needReloadDataNotification), object: nil)
    }

//    MARK: - Fetching

    func loadMoreImages(page: Int)->[ObjectsOnImage]? {
        fetchRequest.fetchOffset = page * Constants.pageSize
        do {
            let objects = try managedContext.fetch(fetchRequest)
            return converter.convert(managedObject: objects)
        } catch {
            print("Fetch failed")
            return nil
        }
    }

//    MARK: - Deleting

    func deleteEntities(with nativeLanguage: Language, and foreignLanguage: Language) {
        let deleteFetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let nativePredicate = NSPredicate(format: "nativeLanguage = %@", nativeLanguage.rawValue)
        let foreignPredicate = NSPredicate(format: "foreignLanguage = %@", foreignLanguage.rawValue)

        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [nativePredicate, foreignPredicate])

        deleteFetchRequest.predicate = andPredicate

        do {
            let objects = try managedContext.fetch(deleteFetchRequest)
            objects.forEach() {
                managedContext.delete($0)
            }

            try managedContext.save()

            NotificationCenter.default.post(name: NSNotification.Name(GlobalConstants.needReloadDataNotification), object: nil)
        } catch {
            fatalError("Error while deleting objects")
        }

    }
}
