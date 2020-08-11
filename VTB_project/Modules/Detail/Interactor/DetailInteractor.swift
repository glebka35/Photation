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
    
    var presenter: DetailInteractorOutput?

//    MARK: - Life cycle

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData), name: NSNotification.Name(GlobalConstants.deletaDataNotification), object: nil)
    }

//    MARK: - Data update

    @objc private func deleteData() {
        presenter?.closeModule()
    }


}
