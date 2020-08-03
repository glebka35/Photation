//
//  ImageHandler.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class ImageHandler {

//    MARK: - Properties

    private let colors: [UIColor] = [.black, .green, .red, .blue, .brown, .orange, .purple, .white]

//    MARK: - Handling

    func handleResponse(objects: [Object], on image: UIImage, completion: (_ object: ObjectsOnImage)->Void) {
        var singleObjects: [SingleObject] = []
        var newImage: UIImage? = image
        for index in 0..<objects.count {
            let rect = CGRect(x: objects[index].x, y: objects[index].y, width: objects[index].width - objects[index].x, height: objects[index].height - objects[index].y)
            let color = colors[index % colors.count]

            newImage = drawRectangleOnImage(with: newImage, and: rect, color: colors[index % colors.count])
            singleObjects.append(SingleObject(nativeName: objects[index].objectClassName, foreignName: objects[index].objectClassName, color: color, isFavorite: .no))
        }

        let objectOnImage = ObjectsOnImage(image: newImage?.jpegData(compressionQuality: 1), objects: singleObjects, nativeLanguage: UserSettings.shared.nativeLanguage, foreignLanguage: UserSettings.shared.foreignLanguage)
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
