//
//  DetailSettingsPresenter.swift
//  Photation
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - DetailSettingsViewOutput

class DetailSettingsPresenter: DetailSettingsViewOutput {

//    MARK: - Properties

    var interactor: DetailSettingsInteractorInput?
    weak var view: DetailSettingsViewInput?
    var router: DetailSettingsRouterInput?

    var model: DetailSettingsViewModel?  {
        didSet {
            if let model = model {
                view?.update(with: model)
            }
        }
    }

//    MARK: - Life cycle

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

//    MARK: - User interaction

    func languageChoosen(at indexPath: IndexPath) {

        if let model = model {
            var cellModels = model.cellModels.map({ (model) -> LanguageCellViewModel in
                LanguageCellViewModel(main: model.main, additional: model.additional, isChosen: false, translationCount: model.translationCount)
            })
            cellModels[indexPath.row].isChosen = true
            self.model?.cellModels = cellModels
        }

        interactor?.languageChosen(at: indexPath)
    }

    func userClosedModule() {
        router?.closeModule()
    }
}

//MARK: - DetailSettingsInteractorOutput

extension DetailSettingsPresenter: DetailSettingsInteractorOutput {

    func update(with cells: [LanguageCellViewModel], and navBar: DefaultNavigationBarModel) {
        model = DetailSettingsViewModel(navBarModel: navBar, cellModels: cells)
    }
}
