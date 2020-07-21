//
//  ImagePickerAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class ImagePickerAssembly: ImagePickerAssemblyProtocol {
   func createImagePickerModule(imagePickerRef: ImagePickerView) {
        let presenter: ImagePickerPresenterProtocol & ImagePickerOutputInteractorProtocol = ImagePickerPresenter()

        imagePickerRef.presenter = presenter
        imagePickerRef.presenter?.assembly = self
        imagePickerRef.presenter?.view = imagePickerRef
        imagePickerRef.presenter?.interactor = ImagePickerInteractor()
        imagePickerRef.presenter?.interactor?.presenter = presenter
    }
}
