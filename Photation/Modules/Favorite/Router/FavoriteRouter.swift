//
//  FavouriteRouter.swift
//  Photation
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class FavoriteRouter: FavoriteRouterInput {
    weak var view: FavoriteView?

    func showDetail(of object: ObjectsOnImage) {
        let detailView = DetailAssembly().createDetailModule(with: object)
        view?.navigationController?.pushViewController(detailView, animated: true)
    }

    func closeModule() {
        view?.dismiss(animated: true, completion: nil)
    }

    func showRememberGame(with objects: [SingleObject]) {
        let rememberView = RememberAssembly().createRememberModule(with: objects)
        view?.navigationController?.pushViewController(rememberView, animated: false)
    }

}
