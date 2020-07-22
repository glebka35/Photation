//
//  ImagePickerProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerViewProtocol: AnyObject {
//    PRESENTER->VIEW
    var presenter: ImagePickerPresenterProtocol? { get set }

    func showCameraImagePicker()
    func showGaleryImagePicker()
}

protocol ImagePickerPresenterProtocol: AnyObject {
//    VIEW->PRESENTER
    var interactor: ImagePickerInputInteractorProtocol? { get set }
    var view: ImagePickerView? { get set }
    var router: ImagePickerRouterInputProtocol? { get set }

    func cameraButtonPressed()
    func galeryButtonPressed()
    func receiveImageFromUser(image: UIImage)
}

protocol ImagePickerInputInteractorProtocol: AnyObject {
//    PRESENTER->INTERACTOR
    var presenter: ImagePickerOutputInteractorProtocol? { get set }
}

protocol ImagePickerOutputInteractorProtocol: AnyObject {
//    INTERACTOR->PRESENTER
}

protocol ImagePickerAssemblyProtocol: AnyObject {
//    PRESENTER->ASSEMBLY
    func createImagePickerModule(imagePickerRef: ImagePickerView)
}

protocol ImagePickerRouterInputProtocol: AnyObject {
//    PRESENTER -> ROUTER
    var view: ImagePickerView? { get set }

    func closeModule()
}
