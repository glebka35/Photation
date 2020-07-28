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
    weak var presenter: ImagePickerInteractorOutput?

    private let cloudMersiveClient = CloudMersiveClient()
    private let translator = Translator()
    private var imageHandler = ImageHandler()

    func handle(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.7) {
            cloudMersiveClient.getRecognition(of: data, name: "") { [weak self] (objects, success) in
                if let objects = objects {
                    self?.imageHandler.handleResponse(objects: objects, on: image) { (objects) in
                        self?.getTranslation(of: objects)
                    }
                }
            }
        }
    }

    private func getTranslation(of objects: ObjectsOnImage) {
        translator.translate(objects: objects, from: .en, to: .es) { (objects) in
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.imageDidRecieved(objects: objects)
            }
        }
    }
}
