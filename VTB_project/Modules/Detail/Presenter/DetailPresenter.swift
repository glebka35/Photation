//
//  DetailPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - DetailViewOutput

class DetailPresenter: DetailViewOutput {

//    MARK: - Properties

    var interactor: DetailInteractorInput?
    weak var view: DetailViewInput?
    var router: DetailRouterInput?

    private var objects: ObjectsOnImage {
        didSet {
            updateData()
        }
    }

    private var navigationBarModel: DefaultNavigationBarModel? {
        didSet {
            updateData()
        }
    }
    private var dataConverter: DetailDataConverterProtocol = DetailDataConverter()

//    MARK: - Life cycle

    init(with object: ObjectsOnImage) {
        self.objects = object
    }

    func viewDidLoad() {
        interactor?.viewDidLoad()
    }

//    MARK: - UI update

    func updateView(with navigationModel: DefaultNavigationBarModel) {
        self.navigationBarModel = navigationModel
    }

    private func updateData() {
        let collectionModel = dataConverter.convert(from: objects)
        if let navModel = navigationBarModel {
            let model = DetailViewModel(defaultNavigationBarModel: navModel, detailCollectionModel: collectionModel)
            view?.updateContent(with: model)
        }
    }

//    MARK: - User interaction

    func wordChosen(at index: Int) {
        let allCases = IsWordFavorite.allCases

        guard let currentIndex = allCases.firstIndex(of: objects.objects[index].isFavorite) else { return }
        let nextIndex = (currentIndex + 1) % allCases.count
        let newFavorite = allCases[nextIndex]
        objects.objects[index].isFavorite = newFavorite

        interactor?.update(object: objects.objects[index])
    }

    func backButtonPressed() {
        router?.closeModule()
    }
}

//MARK: - DetailInteractorOutput

extension DetailPresenter: DetailInteractorOutput {
    func closeModule() {
        router?.closeModule()
    }
}
