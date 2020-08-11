//
//  FavoriteInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class FavoriteInteractor: FavoriteInteractorInput {

//    MARK: - Properties
    
    weak var presenter: FavoriteInteractorOutput?
    private var coreDataStorage = CoreDataStore.shared
    private var page = 0
    private var isStoreEmpty = false
    private var loadMoreStatus = false

//    MARK: - Life cycle

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(GlobalConstants.needReloadDataNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(GlobalConstants.deletaDataNotification), object: nil)
    }

    func viewDidLoad() {
        reloadData()
    }

//    MARK: - Data fetching

    func loadObjects() {
        if !loadMoreStatus && !isStoreEmpty {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.loadMoreStatus = true
                if let page = self?.page, let objects = self?.coreDataStorage.loadFavoriteImages(page: page) {
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
