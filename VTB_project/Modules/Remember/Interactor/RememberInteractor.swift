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

    init(with objects: RememberObjects) {
        self.objects = objects
    }

    func viewDidLoad() {
        wordIndicies = Array(objects.indices).shuffled()
        presenter?.update(objects: objects)
    }

    func displayWord() {
        if let currentIndex = currentIndex {
            presenter?.showWord(at: currentIndex)
        }
    }

    func wordChosen(with name: String, indexPath: IndexPath) {
        if let currentIndex = currentIndex {
            if name == objects[currentIndex].foreignName {
                presenter?.correctWordChosen(at: indexPath)
            } else {
                presenter?.wrongWordChosen(at: indexPath)
            }
        }
    }
}
