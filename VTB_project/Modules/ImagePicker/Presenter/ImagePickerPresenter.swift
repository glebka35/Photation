//
//  ImagePickerPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ImagePickerViewOutput

class ImagePickerPresenter: ImagePickerViewOutput {
//    MARK: -  Properties

    var router: ImagePickerRouterInput?
    var interactor: ImagePickerInteractorInput?
    weak var view: ImagePickerView?

//    MARK: - User interaction

    func cameraButtonPressed() {
        view?.showCameraImagePicker()
    }

    func galeryButtonPressed() {
        view?.showGaleryImagePicker()
    }

    func receiveImageFromUser(image: UIImage) {
        interactor?.handle(image: image)
        view?.showSpinner()
    }
}

//MARK: - ImagePickerInteractorOutput

extension ImagePickerPresenter: ImagePickerInteractorOutput {
    func imageDidRecieved(objects: ObjectsOnImage) {
        view?.unshowSpinner()
        router?.showDetail(of: objects)
    }

    func languageChanged() {
        view?.languageChanged()
    }

}
