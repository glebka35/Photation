//
//  DetailDataConverter.swift
//  Photation
//
//  Created by Gleb Uvarkin on 25.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

protocol DetailDataConverterProtocol {
    func convert(from objects: ObjectsOnImage) -> DetailCollectionModel
}

final class DetailDataConverter: DetailDataConverterProtocol {
    func convert(from objects: ObjectsOnImage) -> DetailCollectionModel {
        if let imageData = objects.image, let image = UIImage(data: imageData) {
            let model = DetailCollectionModel(image: image, nativeLanguage: objects.nativeLanguage.humanRepresentingNative, foreignLanguage: objects.foreignLanguage.humanRepresentingNative, objects: objects.objects)
            return model
        } else {
            return DetailCollectionModel(image: UIImage(), nativeLanguage: objects.nativeLanguage.humanRepresentingNative, foreignLanguage: objects.foreignLanguage.humanRepresentingNative, objects: objects.objects)
        }

    }
}
