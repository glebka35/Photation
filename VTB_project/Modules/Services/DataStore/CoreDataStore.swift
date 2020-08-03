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

//    MARK: - Properties

    private let nativeLanguage: Language
    private let foreignLanguage: Language

    private lazy var converter: CoreDataObjectConverterProtocol = {
        return CoreDataObjectConverter(nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage, context: fetchedResultsController.managedObjectContext)
    } ()

    private lazy var fetchedResultsController: NSFetchedResultsController<ImageEntity> = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("AppDelegate is nil")}

        let managedContext = appDelegate.persistentContainer.newBackgroundContext()
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)

        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchedResultController = NSFetchedResultsController<ImageEntity>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    } ()

//    MARK: - Life cycle

    required init(nativeLanguage: Language,foreignLanguage: Language) {
        self.nativeLanguage = nativeLanguage
        self.foreignLanguage = foreignLanguage
    }

//    MARK: - Saving

    func save(imageWithObjects: ObjectsOnImage) {
        let manageObject = converter.convert(from: imageWithObjects)
        do {
            try manageObject?.managedObjectContext?.save()
        } catch {
            print("Error while saving")
        }
    }

//    MARK: - Fetching

    func loadMoreImages() -> [ObjectsOnImage]? {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Fetch failed")
        }

        guard let managedObjects = fetchedResultsController.fetchedObjects else { return nil }

        return converter.convert(from: managedObjects)
    }

}

extension CoreDataStore: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            print("insert")
        case .delete:
            print("delete")
        case .move:
            print("move")
        case .update:
            print("update")
        default:
            break
        }
    }


}
