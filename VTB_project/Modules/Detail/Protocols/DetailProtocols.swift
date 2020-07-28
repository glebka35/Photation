//
//  DetailProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

// MARK: PRESENTER -> VIEW
protocol DetailViewInput: AnyObject {
    var presenter: DetailViewOutput? { get set }

    func configureCollection(with objects: [SingleObject], and image: UIImage?)
    func updateContent(with objects: [SingleObject])
}

// MARK: VIEW -> PRESENTER
protocol DetailViewOutput: AnyObject {
    var interactor: DetailInteractorInput? { get set }
    var view: DetailViewInput? { get set }
    var router: DetailRouterInput? { get set }

    func viewDidLoad()
    func wordChosen(at index: Int)
    func backButtonPressed()
}

// MARK: PRESENTER -> INTERACTOR
protocol DetailInteractorInput {
    var presenter: DetailInteractorOutput? { get set }
}

// MARK: INTERACTOR -> PRESENTER
protocol DetailInteractorOutput {

}

// MARK: PRESENTER -> ROUTER

protocol DetailRouterInput: AnyObject {
    var view: DetailView? { get set}

    func dismiss()
}
