//
//  SettingsProtocol.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - PRESENTER -> VIEW

protocol SettingsViewInput: AnyObject {
    var presenter: SettingsViewOutput? { get set }

    func updateTable(with data: [[CellViewModel]])
}


//MARK: - VIEW -> PRESENTER

protocol SettingsViewOutput: AnyObject {
    var interactor: SettingsInteractorInput? { get set }
    var view: SettingsViewInput? { get set }
    var router: SettingsRouterInput? { get set }

    func viewDidLoad()
    func settingChoosed(at indexPath: IndexPath)
}

//MARK: - PRESENTER -> INTERACTOR

protocol SettingsInteractorInput: AnyObject {
    var presenter: SettingsInteractorOutput? { get set }

    func viewDidLoad()
}

//MARK:- INTERACTOR -> PRESENTER

protocol SettingsInteractorOutput: AnyObject {
    func display(settings: [[SettingsList]])
}

//MARK:- PRESENTER -> ROUTER

protocol SettingsRouterInput: AnyObject {
    var view: SettingsView? { get set }

    func showDetail(with title: String)
    func closeModeule()
}
