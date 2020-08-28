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
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: NSNotification.Name(NotificionIdentifier.languageChanged), object: nil)
    }

    func viewDidLoad() {
        updateModel()
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
           updateModel()
       }

    private func updateModel() {
        let model = ImagePickerViewModel(navigationBarModel: MainNavigationBarModel(title: LocalizedString().add, additionalTitle: SettingsStore.shared.getForeignLanguage().humanRepresentingNative), cameraButtonTitle: LocalizedString().cameraButton, galeryButtonTitle: LocalizedString().galeryButton)
        presenter?.update(with: model)
    }
}
