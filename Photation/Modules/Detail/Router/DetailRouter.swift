//
//  DetailRouter.swift
//  Photation
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailRouter: DetailRouterInput {
    weak var view: DetailView?

    func closeModule() {
        view?.navigationController?.setNavigationBarHidden(true, animated: false)
        view?.navigationController?.popViewController(animated: true)
    }
}
