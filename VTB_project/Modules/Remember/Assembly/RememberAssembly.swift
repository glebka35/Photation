//
//  RememberAssembly.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class RememberAssembly {
    func createRememberModule(with objects: RememberObjects)->RememberView {
        let presenter: RememberViewOutput & RememberInteractorOutput = RememberPresenter()
        let rememberView = RememberView()
        let router = RememberRouter()
        let interactor = RememberInteractor(with: objects)

        router.view = rememberView

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = rememberView
        presenter.interactor = interactor

        rememberView.presenter = presenter

        return rememberView
    }
    
}
