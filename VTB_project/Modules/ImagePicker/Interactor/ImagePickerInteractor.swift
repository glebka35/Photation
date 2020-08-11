//
//  ImagePickerInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerInteractor: ImagePickerInteractorInput {

    //    MARK: - Properties
    
    weak var presenter: ImagePickerInteractorOutput?

    private let imageWorker: ObjectDetectorAndTranslator = ImageHandlerAndTranslationWorker()
    private var dataStore: DataStoreProtocol = CoreDataStore.shared

    //    MARK: - Life cycle

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(GlobalConstants.needReloadDataNotification), object: nil)
    }

     //    MARK: - Data update

    func handle(image: UIImage) {
        imageWorker.performHandling(image: image) { (objects) in
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.imageDidRecieved(objects: objects)
                self?.dataStore.save(imageWithObjects: objects)
            }
        }
    }

    @objc private func reloadData() {
           presenter?.closeModule()
       }
}
