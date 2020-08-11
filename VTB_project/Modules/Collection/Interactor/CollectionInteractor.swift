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
    private var loadMoreStatus = false
    private var isStoreEmpty = false

    private var page = 0

    //    MARK: - Life cycle
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(GlobalConstants.needReloadDataNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(GlobalConstants.deletaDataNotification), object: nil)
    }

    //    MARK: - Data fetching
    
    func loadObjects() {
        if !loadMoreStatus && !isStoreEmpty {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.loadMoreStatus = true
                if let page = self?.page, let objects = self?.coreDataStorage.loadMoreImages(page: page) {
                    DispatchQueue.main.async {
                        self?.presenter?.objectsDidFetch(objects: objects)
                        self?.page += 1

                        if objects.count == 0 {
                            self?.isStoreEmpty = true
                        }
                    }
                }
                self?.loadMoreStatus = false
            }
        }
    }

    @objc private func reloadData() {
        page = 0
        isStoreEmpty = false
        loadObjects()
    }
}
