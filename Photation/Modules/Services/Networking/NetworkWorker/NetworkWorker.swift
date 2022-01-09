//
//  ImageHandlerAndTranslationWorker.swift
//  Photation
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ObjectDetectorAndTranslator

protocol NetworkWorkingLogic {
    func performHandling(image: UIImage, completion: @escaping (_ objects: ObjectsOnImage?)->Void)
}

//MARK: - ObjectDetectorAndTranslator

class NetworkWorker: NetworkWorkingLogic {

//    MARK: - Properties

    private var imageHandler = ImageHandler()
    private let networkClient = NetworkClient()

//    MARK: - Handling
    
    func performHandling(image: UIImage, completion: @escaping (_ objects: ObjectsOnImage?)->Void) {
        if let data = image.jpegData(compressionQuality: 0.7) {
            let nativeLanguage = SettingsStore.shared.getNativeLanguage().rawValue
            let foreignLanguage = SettingsStore.shared.getForeignLanguage().rawValue
            networkClient.getRecognition(of: data, nativeLang: nativeLanguage, foreignLang: foreignLanguage) { [weak self] (objects, success) in
                if let objects = objects,
                    success {
                    self?.imageHandler.handleResponse(objects: objects, on: image) { objects in
                        completion(objects)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
}
