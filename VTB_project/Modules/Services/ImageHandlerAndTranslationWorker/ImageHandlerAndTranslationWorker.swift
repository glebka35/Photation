//
//  ImageHandlerAndTranslationWorker.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

protocol ObjectDetectorAndTranslator {
    func performHandling(image: UIImage, completion: @escaping (_ objects: ObjectsOnImage)->Void)
}

class ImageHandlerAndTranslationWorker: ObjectDetectorAndTranslator {

    private let cloudMersiveClient = CloudMersiveClient()
    private let translator = Translator()
    private var imageHandler = ImageHandler()
    
    func performHandling(image: UIImage, completion: @escaping (_ objects: ObjectsOnImage)->Void) {
        if let data = image.jpegData(compressionQuality: 0.7) {
            cloudMersiveClient.getRecognition(of: data, name: "") { [weak self] (objects, success) in
                if let objects = objects {
                    self?.imageHandler.handleResponse(objects: objects, on: image) { (objects) in
                        let nativeLanguage = UserSettings.shared.nativeLanguage
                        let foreignLanguage = UserSettings.shared.foreignLanguage
                        self?.getTranslation(of: objects, firstLanguage: nativeLanguage, secondLanguage: foreignLanguage, completion: completion)
                    }
                }
            }
        }
    }

    private func getTranslation(of objects: ObjectsOnImage, firstLanguage: Language, secondLanguage: Language, completion: @escaping (_ objects: ObjectsOnImage)->Void) {
        translator.translate(objects: objects, nativeLang: firstLanguage, foreignLang: secondLanguage) { (objects) in
            completion(objects)
        }
    }
}
