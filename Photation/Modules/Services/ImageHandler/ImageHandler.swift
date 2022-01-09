//
//  ImageHandler.swift
//  Photation
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class ImageHandler {

//    MARK: - Properties

    private let colors: [UIColor] = [.black, .green, .red, .blue, .brown, .orange, .purple, .gray]

//    MARK: - Handling

    func handleResponse(objects: [Object], on image: UIImage, completion: (_ object: ObjectsOnImage)->Void) {
        var singleObjects: [SingleObject] = []
        var newImage: UIImage? = image
        for index in 0..<objects.count {
            let rect = CGRect(x: objects[index].x, y: objects[index].y, width: objects[index].width, height: objects[index].height)
            let color = colors[index % colors.count]

            newImage = drawRectangleOnImage(with: newImage, and: rect, color: colors[index % colors.count])
            singleObjects.append(SingleObject(nativeName: objects[index].nativeLanguage, foreignName: objects[index].foreignLanguage, color: color, isFavorite: .no, id: UUID().uuidString))
        }

        let objectOnImage = ObjectsOnImage(image: newImage?.jpegData(compressionQuality: 1), objects: singleObjects, date: Date(), nativeLanguage: SettingsStore.shared.getNativeLanguage(), foreignLanguage: SettingsStore.shared.getForeignLanguage())
        completion(objectOnImage)
    }


    private func drawRectangleOnImage(with image: UIImage?, and rect: CGRect, color: UIColor)->UIImage? {
        guard let image = image else { return nil }

        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        image.draw(at: CGPoint.zero)
        let path = UIBezierPath(rect: rect)
        color.setStroke()
        path.lineWidth = 10
        path.stroke()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
