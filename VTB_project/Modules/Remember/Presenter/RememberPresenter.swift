//
//  RememberPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - RememberViewOutput

class RememberPresenter: RememberViewOutput {

//    MARK: - Constants

    enum Constants {
        static let variantsCount = 3
    }

//    MARK: - Properties

    weak var view: RememberViewInput?
    var interactor: RememberInteractorInput?
    var router: RememberRouterInput?

    private var objects: RememberObjects = []
    private var currentModel: RememberViewModel?
    private var navigationBarModel: DefaultNavigationBarModel?

//    MARK: - Life cycle

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

//    MARK: - User interaction

    func wordChosen(at indexPath: IndexPath) {
        if let word = currentModel?.gameModel.variants[indexPath.row] {
            interactor?.wordChosen(with: word, indexPath: indexPath)
        }
    }

    func backButtonPressed() {
        router?.closeModule()
    }

    func nextButtonPressed() {
        interactor?.displayWord()
    }

}

//MARK: - RememberInteractorOutput

extension RememberPresenter: RememberInteractorOutput {
    func update(objects: RememberObjects) {
        self.objects = objects
    }

    func showWord(at index: Int, with footerModel: FooterModel, and navBarModel: DefaultNavigationBarModel) {
        let gameModel = createGameModel(with: index)

        let model = RememberViewModel(navigationBarModel: navBarModel, gameModel: gameModel, footerModel: footerModel)
        view?.hideNextButton()
        view?.update(with: model)
        self.currentModel = model

    }

    private func createGameModel(with mainIndex: Int)->RememberGameModel {
        var objectsCopy = objects

        let mainObject = objectsCopy.remove(at: mainIndex)
        var variants: [String] = [mainObject.nativeName]

        objectsCopy.shuffle()

        let limit = min(Constants.variantsCount, objectsCopy.count)

        for index in 0..<limit {
            variants.append(objectsCopy[index].nativeName)
        }

        variants.shuffle()

        let currentGameModel = RememberGameModel(mainWord: mainObject.foreignName, variants: variants)
        return currentGameModel
    }

    func correctWordChosen(at indexPath: IndexPath) {
        view?.emphasizeCorrectWord(at: indexPath)
        view?.showNextButton()
    }

    func wrongWordChosen(at indexPath: IndexPath) {
        view?.emphasizeWrongWord(at: indexPath)
    }

    func update(footer: FooterModel) {
        if let navBarModel = currentModel?.navigationBarModel, let gameModel = currentModel?.gameModel {
            let model = RememberViewModel(navigationBarModel: navBarModel, gameModel: gameModel, footerModel: footer)
            view?.update(with: model)
            currentModel = model
        }
    }

    func close() {
        router?.closeModule()
    }
}
