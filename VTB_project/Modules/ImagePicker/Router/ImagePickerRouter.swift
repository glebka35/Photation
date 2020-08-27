//
//  ImagePickerRouter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 22.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class ImagePickerRouter: ImagePickerRouterInput {
    weak var view: ImagePickerView?

    func closeModule() {
        view?.dismiss(animated: true, completion: nil)
    }

    func showDetail(of object: ObjectsOnImage) {
        let detailView = DetailAssembly().createDetailModule(with: object)
        view?.navigationController?.pushViewController(detailView, animated: true)
    }

    func showAlert() {
        let alert = UIAlertController(title: LocalizedString().emptyObjectAlertTitle, message: LocalizedString().alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizedString().alertCancelTitle, style: .cancel))
        view?.present(alert, animated: true)
    }

}
