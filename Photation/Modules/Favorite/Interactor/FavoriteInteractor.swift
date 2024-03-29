//
//  FavoriteInteractor.swift
//  Photation
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class FavoriteInteractor: FavoriteInteractorInput {

    //    MARK: - Properties
    
    weak var presenter: FavoriteInteractorOutput?
    private let coreDataStorage: CoreDataStore = CoreDataStore.shared
    private var predicates: [String:String]  {
        ["isFavorite" : "1",
         "image." + ConstantsKeys.nativeLanguage : SettingsStore.shared.getNativeLanguage().rawValue,
         "image." + ConstantsKeys.foreignLanguage : SettingsStore.shared.getForeignLanguage().rawValue]
    }
    private var page = 0
    private var isStoreEmpty = false
    private var loadMoreStatus = false

    private var viewLoaded = false

    //    MARK: - Life cycle

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(NotificionIdentifier.deletaDataNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(NotificionIdentifier.dataModified), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: NSNotification.Name(NotificionIdentifier.languageChanged), object: nil)
    }

    func viewDidLoad() {
        viewLoaded = true
        setNavigationBar()
        loadObjects()
    }


    //    MARK: - Data fetching

    func loadObjects() {
        if !loadMoreStatus && !isStoreEmpty {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.loadMoreStatus = true
                if let self = self {
                    let (objects, images) = self.coreDataStorage.loadFavoriteImages(page: self.page, with: self.predicates)
                    DispatchQueue.main.async {
                        if let images = images, let objects = objects {
                            if objects.count == 0 {
                                self.isStoreEmpty = true
                            } else {
                                self.presenter?.objectsDidFetch(images: images, objects: objects)
                                self.page += 1
                            }
                        }
                    }
                }
                self?.loadMoreStatus = false
            }
        }
    }

    private func setNavigationBar() {
        let model = MainNavigationBarModel(title: LocalizedString().favorite, additionalTitle: "", buttonTitle: LocalizedString().remember)
        presenter?.updateNavigation(with: model)
        
    }

    @objc private func reloadData() {
        if viewLoaded {
            deleteData()

            page = 0
            isStoreEmpty = false
            loadObjects()
        }
    }

    private func deleteData() {
        presenter?.deleteData()
    }

    @objc private func languageChanged() {
        if viewLoaded {
            reloadData()
        }
        setNavigationBar()
    }
}
