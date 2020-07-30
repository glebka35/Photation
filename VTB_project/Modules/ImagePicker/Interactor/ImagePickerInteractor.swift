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

    private let imageWorker: ObjectDetectorAndTranslator = ImageHandlerAndTranslationWorker()

    func handle(image: UIImage) {
        imageWorker.performHandling(image: image) { (objects) in
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.imageDidRecieved(objects: objects)
            }
        }
    }
}
