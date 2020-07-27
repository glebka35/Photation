//
//  ImagePickerAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class ImagePickerAssembly {
   func createImagePickerModule()->ImagePickerView {
        let presenter: ImagePickerPresenterProtocol & ImagePickerOutputInteractorProtocol = ImagePickerPresenter()
        let view = ImagePickerView()
        let router = ImagePickerRouter()
        let interactor = ImagePickerInteractor()

        router.view = view

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        view.presenter = presenter

        return view
    }
}
