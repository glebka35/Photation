//
//  RememberProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - PRESENTER -> VIEW

protocol RememberViewInput: AnyObject {
    var presenter: RememberViewOutput? { get set }

    func update(with model: RememberViewModel)
    func emphasizeCorrectWord(at indexPath: IndexPath)
    func emphasizeWrongWord(at indexPath: IndexPath)

    func showNextButton()
    func hideNextButton()

}

//MARK: - VIEW -> PRESENTER

protocol RememberViewOutput: AnyObject {
    var view: RememberViewInput? { get set }
    var interactor: RememberInteractorInput? { get set }
    var router: RememberRouterInput? { get set }

    func viewDidLoad()
    func wordChosen(at indexPath: IndexPath)
    func backButtonPressed()
    func nextButtonPressed()
}

//MARK: - PRESENTER -> INTERACTOR

protocol RememberInteractorInput: AnyObject {
    var presenter: RememberInteractorOutput? { get set }

    func viewDidLoad()
    func wordChosen(with name: String, indexPath: IndexPath)
    func displayWord()
}

//MARK: - INTERACTOR -> PRESENTER

protocol RememberInteractorOutput: AnyObject {
    func update(objects: RememberObjects)
    func showWord(at index: Int, with footerModel: FooterModel, and navBarModel: DefaultNavigationBarModel)

    func correctWordChosen(at indexPath: IndexPath)
    func wrongWordChosen(at indexPath: IndexPath)
    func update(footer: FooterModel)
    func close()
}

//MARK: - PRESENTER -> ROUTER

protocol RememberRouterInput: AnyObject {
    var view: RememberView? { get set }

    func closeModule()
}
