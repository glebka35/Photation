//
//  RememberPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class RememberPresenter: RememberViewOutput {

    enum Constants {
        static let variantsCount = 3
    }

    weak var view: RememberViewInput?
    var interactor: RememberInteractorInput?
    var router: RememberRouterInput?

    private var objects: RememberObjects = []
    private var currentGameModel: RememberGameModel?

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

    func wordChosen(at indexPath: IndexPath) {
        if let word = currentGameModel?.variants[indexPath.row] {
            interactor?.wordChosen(with: word, indexPath: indexPath)
        }
    }

}

extension RememberPresenter: RememberInteractorOutput {
    func update(objects: RememberObjects) {
        self.objects = objects
    }

    func showWord(at index: Int) {
        let gameModel = createGameModel(with: index)
        view?.update(with: gameModel)
    }

    private func createGameModel(with mainIndex: Int)->RememberGameModel {
        var objectsCopy = objects

        let mainObject = objectsCopy.remove(at: mainIndex)
        var variants: [String] = [mainObject.nativeName]

        objectsCopy.shuffle()

        let limit = min(Constants.variantsCount, objectsCopy.count)

        for index in 1...limit {
            variants.append(objectsCopy[index].nativeName)
        }

        variants.shuffle()
        return RememberGameModel(mainWord: mainObject.foreignName ?? "", variants: variants)
    }

    func correctWordChosen(at indexPath: IndexPath) {
        view?.emphasizeCorrectWord(at: indexPath)
        view?.showNextButton()
    }

    func wrongWordChosen(at indexPath: IndexPath) {
        view?.emphasizeWrongWord(at: indexPath)
        view?.showNextButton()
    }


}
