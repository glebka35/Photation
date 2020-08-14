//
//  ImagePickerProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PRESENTER->VIEW


protocol ImagePickerViewInput: AnyObject {
    var presenter: ImagePickerViewOutput? { get set }

    func showCameraImagePicker()
    func showGaleryImagePicker()
    func showSpinner()
    func unshowSpinner()
    func languageChanged()
}

//MARK: - VIEW->PRESENTER


protocol ImagePickerViewOutput: AnyObject {
    var interactor: ImagePickerInteractorInput? { get set }
    var view: ImagePickerView? { get set }
    var router: ImagePickerRouterInput? { get set }

    func cameraButtonPressed()
    func galeryButtonPressed()
    func receiveImageFromUser(image: UIImage)
}

//MARK: - PRESENTER->INTERACTOR


protocol ImagePickerInteractorInput: AnyObject {
    var presenter: ImagePickerInteractorOutput? { get set }
    func handle(image: UIImage)
}

//MARK: - INTERACTOR->PRESENTER

protocol ImagePickerInteractorOutput: AnyObject {
    func imageDidRecieved(objects: ObjectsOnImage)

    func languageChanged()
}

//MARK: - PRESENTER -> ROUTER

protocol ImagePickerRouterInput: AnyObject {
    var view: ImagePickerView? { get set }

    func showDetail(of object: ObjectsOnImage)
    func closeModule()
}
