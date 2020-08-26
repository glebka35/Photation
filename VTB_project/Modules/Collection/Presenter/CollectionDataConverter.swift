//
//  DataConverter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 25.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

protocol ObjectToImageViewConverterProtocol {
    func convertToImage(from data: [ObjectsOnImage]) -> [ImageStyleObject]
}

protocol ObjectToTableViewConverterProtocol {
    func convertToTable(from data: [ObjectsOnImage]) -> [TableStyleObject]
}

final class CollectionViewDataConverter: ObjectToImageViewConverterProtocol, ObjectToTableViewConverterProtocol {

    func convertToImage(from data: [ObjectsOnImage]) -> [ImageStyleObject] {
        var objects: [ImageStyleObject] = []

        data.forEach {
            if let imageData = $0.image, let image = UIImage(data: imageData), let firstObjectName = $0.objects.first?.foreignName {
                objects.append(ImageStyleObject(image: image, objectName: firstObjectName, id: $0.date))
            }
        }

        return objects
    }

    func convertToTable(from data: [ObjectsOnImage]) -> [TableStyleObject] {
        var objects: [TableStyleObject] = []

        data.forEach { image in
            image.objects.forEach {
                objects.append(TableStyleObject(nativeName: $0.nativeName, foreignName: $0.foreignName ?? "", id: image.date))
            }
        }

        return objects
    }
}
