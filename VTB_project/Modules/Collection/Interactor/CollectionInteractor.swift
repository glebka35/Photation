//
//  CollectionInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class CollectionInteractor: CollectionInteractorInput {

    //    MARK: - Properties

    weak var presenter: CollectionInteractorOutput?
    private let coreDataStorage = CoreDataStore.shared
    private let predicates = [
        ConstantsKeys.nativeLanguage : SettingsStore.shared.getNativeLanguage().rawValue,
        ConstantsKeys.foreignLanguage : SettingsStore.shared.getForeignLanguage().rawValue
    ]
    private var loadMoreStatus = false
    private var isStoreEmpty = false

    private var page = 0

    //    MARK: - Life cycle
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(GlobalConstants.newImageAdded), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData), name: NSNotification.Name(GlobalConstants.deletaDataNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(GlobalConstants.dataModified), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: NSNotification.Name(GlobalConstants.languageChanged), object: nil)
    }

    func viewDidLoad() {
        setNavigationBar()
        loadObjects()
    }

    //    MARK: - Data fetching
    
    func loadObjects() {
        if !loadMoreStatus && !isStoreEmpty {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.loadMoreStatus = true
                if let self = self, let objects = self.coreDataStorage.loadMoreImages(page: self.page, with: self.predicates) {
                    DispatchQueue.main.async {
                        self.presenter?.objectsDidFetch(objects: objects)
                        self.page += 1

                        if objects.count == 0 {
                            self.isStoreEmpty = true
                        }
                    }
                }
                self?.loadMoreStatus = false
            }
        }
    }

    @objc private func reloadData() {
        deleteData()
        
        page = 0
        isStoreEmpty = false
        loadObjects()
    }

    @objc private func deleteData() {
        presenter?.deleteData()
    }

    @objc private func languageChanged() {
        setNavigationBar()
        reloadData()
    }

    private func setNavigationBar() {
        let navModel = MainNavigationBarModel(title: LocalizedString().collection, additionalTitle:
            SettingsStore.shared.getForeignLanguage().humanRepresentingNative)
        presenter?.updateNavigation(with: navModel)
    }
}
