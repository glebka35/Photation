//
//  RememberInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class RememberInteractor: RememberInteractorInput {
    weak var presenter: RememberInteractorOutput?

    private let objects: RememberObjects
    private var wordIndicies: [Int] = []
    private var currentIndex: Int? {
        wordIndicies.first
    }
    private var footerModel = FooterModel(currentIndex: 0, amount: 0)

    init(with objects: RememberObjects) {
        self.objects = objects
    }

    func viewDidLoad() {
        wordIndicies = Array(objects.indices).shuffled()
        presenter?.update(objects: objects)
        footerModel.amount = objects.count
        displayWord()
    }

    func displayWord() {
        if wordIndicies.isEmpty {
            presenter?.close()
        } else {
            footerModel.currentIndex += 1
            if let currentIndex = currentIndex {
                presenter?.showWord(at: currentIndex, with: footerModel, and: getNavigationBar())
            }
        }
    }

    func wordChosen(with name: String, indexPath: IndexPath) {
        if let currentIndex = currentIndex {
            if name == objects[currentIndex].nativeName {
                presenter?.correctWordChosen(at: indexPath)
                updateFooter()
                wordIndicies.removeFirst()
            } else {
                presenter?.wrongWordChosen(at: indexPath)
            }
        }
    }

    private func updateFooter() {
        presenter?.update(footer: footerModel)
    }

    private func getNavigationBar()->DefaultNavigationBarModel {
        let navigationBarModel = DefaultNavigationBarModel(title: LocalizedString().remember, backButtonTitle: LocalizedString().backButton)
        return navigationBarModel
        
    }
}
