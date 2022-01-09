//
//  SettingsPresenter.swift
//  Photation
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

    var currentModel: SettingsViewModel? {
        didSet {
            if let model = currentModel {
                view?.updateTable(with: model)
            }
        }
    }

    //    MARK: - Life cycle

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

    //    MARK: - User interaction

    func settingChoosed(at indexPath: IndexPath) {
        if let model = currentModel {
            if model.cellModels.count - 1 != indexPath.section {
                switch indexPath.row {
                case 0:
                    router?.showDetail(with: .mainLanguage)
                case 1:
                    router?.showDetail(with: .foreignLanguage)
                default:
                    break
                }
            } else {
                interactor?.deleteData()
            }
        }
    }

}

//MARK: - SettingsInteractorOutput

extension SettingsPresenter: SettingsInteractorOutput {
    func display(settings: [[SettingsList]], with navBarModel: MainNavigationBarModel) {
        var data: [[SettingsCellViewModel]] = []
        var section: [SettingsCellViewModel] = []

        settings.forEach {
            $0.forEach {
                section.append(SettingsCellViewModel(title: LocalizedString().getSettingsString(settings: $0), image: $0.image))
            }
            data.append(contentsOf: [section])
            section = []
        }

        let model = SettingsViewModel(navigationBarModel: navBarModel, cellModels: data)
        self.currentModel = model
    }
}
