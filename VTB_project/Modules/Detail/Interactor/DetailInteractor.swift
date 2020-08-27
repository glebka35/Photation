//
//  DetailInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailInteractor: DetailInteractorInput {

//    MARK: -  Properties
    
    weak var presenter: DetailInteractorOutput?

    private var coreDataStorage = CoreDataStore.shared

//    MARK: - Life cycle

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData), name: NSNotification.Name(GlobalConstants.deletaDataNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData), name: NSNotification.Name(GlobalConstants.languageChanged), object: nil)
    }

    func viewDidLoad() {
        let title = LocalizedString().image
        let backButtonTitle = LocalizedString().backButton

        presenter?.updateView(with: DefaultNavigationBarModel(title: title, backButtonTitle: backButtonTitle))
    }

//    MARK: - Data update

    @objc private func deleteData() {
        presenter?.closeModule()
    }

    func update(object: SingleObject) {
        coreDataStorage.updateEntity(with: object)
    }

}
