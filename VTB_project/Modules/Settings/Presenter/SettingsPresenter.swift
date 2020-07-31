//
//  SettingsPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class SettingsPresenter: SettingsViewOutput {
    var interactor: SettingsInteractorInput?
    weak var view: SettingsViewInput?
    var router: SettingsRouterInput?

    var data: [[CellViewModel]] = [] {
        didSet {
            view?.updateTable(with: data)
        }
    }

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

    func settingChoosed(at indexPath: IndexPath) {
        if data.count - 1 != indexPath.section {
            router?.showDetail(with: data[indexPath.section][indexPath.row].title)
        }
    }
}

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
