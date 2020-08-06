//
//  CollectionInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit // Надо убрать отсюда зависимость от UIKit, пока этого нельзя сделать, так как
// вместо картинок использую заглушки из ассетов, но после подключения api эта проблема уйдет

class CollectionInteractor: CollectionInteractorInput {

    //    MARK: - Properties

    weak var presenter: CollectionInteractorOutput?
    private var coreDataStorage = CoreDataStore.shared

    private var page = 0

    //    MARK: - Life cycle
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(newImageAdded), name: NSNotification.Name(GlobalConstants.newImageAddedNotificationName), object: nil)
    }

    //    MARK: - Data fetching
    
    func loadObjects(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let page = self?.page, let objects = self?.coreDataStorage.loadMoreImages(page: page) {
                DispatchQueue.main.async {
                    completion()
                    self?.presenter?.objectsDidFetch(objects: objects)
                    self?.page += 1
                }
            }
        }
    }

    @objc private func newImageAdded() {
        page = 0
        loadObjects {}
    }
}
