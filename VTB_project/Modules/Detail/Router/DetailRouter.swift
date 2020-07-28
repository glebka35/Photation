//
//  DetailRouter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailRouter: DetailRouterInput {
    var view: DetailView?

    func dismiss() {
        view?.navigationController?.setNavigationBarHidden(true, animated: false)
        view?.navigationController?.popViewController(animated: true)
    }
}
