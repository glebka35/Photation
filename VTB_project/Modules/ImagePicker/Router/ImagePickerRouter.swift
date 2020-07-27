//
//  ImagePickerRouter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 22.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class ImagePickerRouter: ImagePickerRouterInput {
    weak var view: ImagePickerView?

    func closeModule() {
        view?.dismiss(animated: true, completion: nil)
    }
}
