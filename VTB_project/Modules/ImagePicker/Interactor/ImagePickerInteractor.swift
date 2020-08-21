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
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: NSNotification.Name(GlobalConstants.languageChanged), object: nil)
    }

     //    MARK: - Data update

    func handle(image: UIImage) {
        imageWorker.performHandling(image: image) { (objects) in
            DispatchQueue.main.async { [weak self] in
                if let objects = objects {
                    self?.presenter?.imageDidRecieved(objects: objects)
                    self?.dataStore.save(imageWithObjects: objects)
                } else {
                    self?.presenter?.didReceivedEmptyObjects()
                }

            }
        }
    }

    @objc private func languageChanged() {
           presenter?.languageChanged()
       }
}
