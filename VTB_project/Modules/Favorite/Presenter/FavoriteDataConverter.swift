//
//  FavoriteDataConverter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 25.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

protocol SingleObjectsToTableViewConverterProtocol {
    func convertToTable(from data: [SingleObject], and images: [ObjectsOnImage]) -> [TableStyleObject]
}

final class SingleObjectsToTableViewConverter: SingleObjectsToTableViewConverterProtocol {
    func convertToTable(from data: [SingleObject], and images: [ObjectsOnImage]) -> [TableStyleObject] {
        var tableObjects: [TableStyleObject] = []

        for index in 0..<data.count {
            if let foreignName = data[index].foreignName {
                tableObjects.append(TableStyleObject(nativeName: data[index].nativeName, foreignName: foreignName, id: images[index].date))
            }
        }

        return tableObjects
    }
}
