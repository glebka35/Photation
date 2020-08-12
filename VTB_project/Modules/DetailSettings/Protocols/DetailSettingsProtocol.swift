//
//  DetailSettingsProtocol.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - PRESENTER -> VIEW

protocol DetailSettingsViewInput: AnyObject {
    var presenter: DetailSettingsViewOutput? { get set }

    func set(title: String)
    func updateTable(with data: [LanguageCellViewModel])
}

//MARK: - VIEW -> PRESENTER

protocol DetailSettingsViewOutput: AnyObject {
    var interactor: DetailSettingsInteractorInput? { get set }
    var view: DetailSettingsViewInput? { get set }
    var router: DetailSettingsRouterInput? { get set }

    func viewDidLoad()
    func languageChoosen(at indexPath: IndexPath)
    func backButtonPressed()
}

//MARK: - PRESENTER -> INTERACTOR

protocol DetailSettingsInteractorInput: AnyObject {
    var presenter: DetailSettingsInteractorOutput? { get set }

    func viewDidLoad()
    func languageChosen(at indexPath: IndexPath, settings: SettingsList)

}

//MARK:- INTERACTOR -> PRESENTER

protocol DetailSettingsInteractorOutput: AnyObject {
    func display(languages: [Language])
}

//MARK:- PRESENTER -> ROUTER

protocol DetailSettingsRouterInput: AnyObject {
    var view: DetailSettingsView? { get set }

    func closeModule()
}
