//
//  DetailView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class DetailView: UIViewController, DetailViewInput {
    var presenter: DetailViewOutput?

    private var collectionSupervisor: DetailCollectionSupervisorProtocol?
    private var objectsImageView = UIImageView()
    private var navigationBar: DefaultNavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Изображение"

        addAndConfigureNavigationBar()
        addAndConfigureImageView()
        addAndConfigureNavigationBar()

        presenter?.viewDidLoad()
    }

    func configureCollection(with objects: [SingleObject], and image: UIImage?) {
        collectionSupervisor = DetailCollectionSupervisor(with: objects)
        collectionSupervisor?.delegate = self

        if let collectionView = collectionSupervisor?.getConfiguredCollection() {
            view.addSubview(collectionView)

            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                collectionView.topAnchor.constraint(equalTo: objectsImageView.bottomAnchor, constant: 20)
            ])
        }
        setImage(image: image)
    }

    func updateContent(with objects: [SingleObject]) {
        collectionSupervisor?.updateContent(with: objects)
    }

    private func addAndConfigureNavigationBar() {
        let navigationBar = DefaultNavigationBar(title: title, backButtonTitle: "Назад", backButtonImage: UIImage(named: "leftAccessory"))
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

    private func setImage(image: UIImage?) {
        objectsImageView.image = image
    }

    private func addAndConfigureImageView() {
        view.addSubview(objectsImageView)

        objectsImageView.layer.cornerRadius = 10
        objectsImageView.clipsToBounds = true

        objectsImageView.translatesAutoresizingMaskIntoConstraints = false

        if let navigationBar = navigationBar {
            NSLayoutConstraint.activate([
                objectsImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                objectsImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                objectsImageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
                objectsImageView.heightAnchor.constraint(equalToConstant: 0.6 * view.frame.width)
            ])
        }
    }
}

extension DetailView: DetailCollectionSupervisorDelegate {
    func wordChosen(at index: Int) {
        presenter?.wordChosen(at: index)
    }
}

extension DetailView: NavigationBarDelegate {
    func action(sender: UIButton!) {
        presenter?.backButtonPressed()
    }
}
