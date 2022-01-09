//
//  DetailProtocols.swift
//  Photation
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

// MARK: PRESENTER -> VIEW
protocol DetailViewInput: AnyObject {
    var presenter: DetailViewOutput? { get set }

    func updateContent(with model: DetailViewModel)
}

// MARK: VIEW -> PRESENTER
protocol DetailViewOutput: AnyObject {
    var interactor: DetailInteractorInput? { get set }
    var view: DetailViewInput? { get set }
    var router: DetailRouterInput? { get set }

    func viewDidLoad()
    func wordChosen(at index: Int)
    func userClosedModule()
}

// MARK: PRESENTER -> INTERACTOR
protocol DetailInteractorInput: AnyObject {
    var presenter: DetailInteractorOutput? { get set }

    func viewDidLoad()
    func update(object: SingleObject)
}

// MARK: INTERACTOR -> PRESENTER
protocol DetailInteractorOutput: AnyObject {
    func updateView(with navigationModel: DefaultNavigationBarModel)
    func closeModule()
}

// MARK: PRESENTER -> ROUTER

protocol DetailRouterInput: AnyObject {
    var view: DetailView? { get set}

    func closeModule()
}
