//
//  ImagePickerPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerPresenter: ImagePickerPresenterProtocol {
    var assembly: ImagePickerAssemblyProtocol?
    var interactor: ImagePickerInputInteractorProtocol?
    weak var view: ImagePickerView?

    func cameraButtonPressed() {
        view?.showCameraImagePicker()
    }

    func galeryButtonPressed() {
        view?.showGaleryImagePicker()
    }

    func receiveImageFromUser(image: UIImage) {
        print("good")
    }
}

extension ImagePickerPresenter: ImagePickerOutputInteractorProtocol {

}
