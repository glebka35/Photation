//
//  CollectionRouter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 22.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class CollectionRouter: CollectionRouterInputProtocol {
    weak var view: CollectionView?

    func closeModule() {
        view?.dismiss(animated: true, completion: nil)
    }
}
