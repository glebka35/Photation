//
//  ImagePickerPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerPresenter: ImagePickerViewOutput {
    var router: ImagePickerRouterInput?
    var interactor: ImagePickerInteractorInput?
    weak var view: ImagePickerView?

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

extension ImagePickerPresenter: ImagePickerInteractorOutput {
    func imageDidRecieved(objects: ObjectsOnImage) {
        view?.unshowSpinner()
        router?.showDetail(of: objects)
    }

}
