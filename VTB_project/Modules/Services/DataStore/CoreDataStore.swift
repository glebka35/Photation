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

    private lazy var favoriteFetchRequest: NSFetchRequest<ImageEntity> = {
        let favoriteFetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)

        favoriteFetchRequest.fetchBatchSize = Constants.pageSize
        favoriteFetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "object.isFavorite == true")

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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalConstants.needReloadDataNotification), object: nil)
        }
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

    func loadFavoriteImages(page: Int)->[ObjectsOnImage]? {
        favoriteFetchRequest.fetchOffset = page * Constants.pageSize
        do {
            let objects = try managedContext.fetch(favoriteFetchRequest)
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

            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(GlobalConstants.deletaDataNotification), object: nil)
            }
        } catch {
            fatalError("Error while deleting objects")
        }

    }
}
