//
//  RememberRouter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class RememberRouter: RememberRouterInput {
    weak var view: RememberView?

    func closeModule() {
        view?.dismiss(animated: true, completion: nil)
    }
}
