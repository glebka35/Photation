//
//  FavoritePresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class FavoritePresenter: NSObject, FavoriteViewOutput {
    var interactor: FavoriteInteractorInput?
    var view: FavoriteViewInput?
    var router: FavoriteRouterInput?

    func viewDidLoad(with style: PresentationStyle) {

    }

    func cellSelected(at indexPath: IndexPath) {

    }

    func scrollViewDidScrollToBottom() {

    }


}

extension FavoritePresenter: FavoriteInteractorOutput {
    func objectsDidFetch(objects: [ObjectsOnImage]) {

    }
}
