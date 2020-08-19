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
    private var currentGameModel: RememberGameModel?

//    MARK: - Life cycle

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

//    MARK: - User interaction

    func wordChosen(at indexPath: IndexPath) {
        if let word = currentGameModel?.variants[indexPath.row] {
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

    func showWord(at index: Int, with footerModel: FooterModel) {
        let gameModel = createGameModel(with: index, and: footerModel)
        view?.hideNextButton()
        view?.update(with: gameModel)
    }

    private func createGameModel(with mainIndex: Int, and footerModel: FooterModel)->RememberGameModel {
        var objectsCopy = objects

        let mainObject = objectsCopy.remove(at: mainIndex)
        var variants: [String] = [mainObject.nativeName]

        objectsCopy.shuffle()

        let limit = min(Constants.variantsCount, objectsCopy.count)

        for index in 0..<limit {
            variants.append(objectsCopy[index].nativeName)
        }

        variants.shuffle()

        let currentGameModel = RememberGameModel(mainWord: mainObject.foreignName ?? "", variants: variants, footerModel: footerModel)
        self.currentGameModel = currentGameModel
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
        currentGameModel?.footerModel = footer
        view?.update(footerWith: footer)
    }

    func close() {
        router?.closeModule()
    }
}
