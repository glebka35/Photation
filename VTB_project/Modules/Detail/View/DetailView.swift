//
//  DetailView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class DetailView: UIViewController, DetailViewInput {

//    MARK: - Properties

    var presenter: DetailViewOutput?

    private var collectionSupervisor: DetailCollectionSupervisorProtocol?
    private var objectsImageView = UIImageView()
    private var navigationBar: DefaultNavigationBar?

//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = LocalizedString().image

        addAndConfigureNavigationBar()
        addAndConfigureNavigationBar()

        presenter?.viewDidLoad()
    }

//    MARK: - UI configuration

    func configureCollection(with objects: ObjectsOnImage) {
        collectionSupervisor = DetailCollectionSupervisor(with: objects, nativeLanguage: objects.nativeLanguage, foreignLanguage: objects.foreignLanguage)
        collectionSupervisor?.delegate = self

        if let collectionView = collectionSupervisor?.getConfiguredCollection() {
            view.addSubview(collectionView)

            if let navigationBar = navigationBar {
                NSLayoutConstraint.activate([
                    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                    collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20)
                ])
            }

        }
    }

    private func addAndConfigureNavigationBar() {
        let navigationBar = DefaultNavigationBar(title: title, backButtonTitle: LocalizedString().backButton, backButtonImage: UIImage(named: "leftAccessory"))
        view.addSubview(navigationBar)
        navigationBar.delegate = self

        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 40)
        ])

        self.navigationBar = navigationBar
    }

//    MARK: - UI update

    func updateContent(with objects: ObjectsOnImage) {
        collectionSupervisor?.updateContent(with: objects)
    }
}

//MARK: - DetailCollectionSupervisor delegate

extension DetailView: DetailCollectionSupervisorDelegate {
    func wordChosen(at index: Int) {
        presenter?.wordChosen(at: index)
    }
}

//MARK: - NavigationBar delegate

extension DetailView: NavigationBarDelegate {
    func action(sender: UIButton!) {
        presenter?.backButtonPressed()
    }
}
