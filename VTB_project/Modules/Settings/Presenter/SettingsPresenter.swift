//
//  SettingsPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - SettingsViewOutput

class SettingsPresenter: SettingsViewOutput {

//    MARK: - Properties

    var interactor: SettingsInteractorInput?
    weak var view: SettingsViewInput?
    var router: SettingsRouterInput?

    var data: [[CellViewModel]] = [] {
        didSet {
            view?.updateTable(with: data)
        }
    }

//    MARK: - Life cycle

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

//    MARK: - User interaction

    func settingChoosed(at indexPath: IndexPath) {
        if data.count - 1 != indexPath.section {
            router?.showDetail(with: data[indexPath.section][indexPath.row].title)
        } else {
            interactor?.deleteData()
        }
    }
}

//MARK: - SettingsInteractorOutput

extension SettingsPresenter: SettingsInteractorOutput {
    func display(settings: [[SettingsList]]) {
        var data: [[CellViewModel]] = []
        var section: [CellViewModel] = []

        settings.forEach {
            $0.forEach {
                section.append(CellViewModel(title: $0.rawValue, image: $0.image))
            }
            data.append(contentsOf: [section])
            section = []
        }

        self.data = data
    }
}
