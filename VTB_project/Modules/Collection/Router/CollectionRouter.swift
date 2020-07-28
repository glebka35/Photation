//
//  CollectionRouter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 22.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class CollectionRouter: CollectionRouterInput {
    weak var view: CollectionView?

    func showDetail(of object: ObjectsOnImage) {
        let detailView = DetailAssembly().createDetailModule(with: object)
        view?.navigationController?.pushViewController(detailView, animated: true)
    }

    func closeModule() {
        view?.dismiss(animated: true, completion: nil)
    }
}
