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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalConstants.newImageAddedNotificationName), object: nil)
    }

//    MARK: - Fetching

    func loadMoreImages(page: Int)->[ObjectsOnImage]? {
        fetchRequest.fetchOffset = page * Constants.pageSize
        do {
            if let objects = try managedContext.fetch(fetchRequest) as? [ImageEntity] {
                return converter.convert(managedObject: objects)
            }
            return nil
        } catch {
            print("Fetch failed")
            return nil
        }
    }
}
