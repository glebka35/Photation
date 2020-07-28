//
//  ImagePickerProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerViewInput: AnyObject {
//    PRESENTER->VIEW
    var presenter: ImagePickerViewOutput? { get set }

    func showCameraImagePicker()
    func showGaleryImagePicker()
    func showSpinner()
    func unshowSpinner()
}

protocol ImagePickerViewOutput: AnyObject {
//    VIEW->PRESENTER
    var interactor: ImagePickerInteractorInput? { get set }
    var view: ImagePickerView? { get set }
    var router: ImagePickerRouterInput? { get set }

    func cameraButtonPressed()
    func galeryButtonPressed()
    func receiveImageFromUser(image: UIImage)
}

protocol ImagePickerInteractorInput: AnyObject {
//    PRESENTER->INTERACTOR
    var presenter: ImagePickerInteractorOutput? { get set }
    func handle(image: UIImage)
}

protocol ImagePickerInteractorOutput: AnyObject {
//    INTERACTOR->PRESENTER
    func imageDidRecieved(objects: ObjectsOnImage)
}

protocol ImagePickerRouterInput: AnyObject {
//    PRESENTER -> ROUTER
    var view: ImagePickerView? { get set }

    func showDetail(of object: ObjectsOnImage)
    func closeModule()
}
