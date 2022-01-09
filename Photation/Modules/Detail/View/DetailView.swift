//
//  DetailView.swift
//  Photation
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

        addAndConfigureNavigationBar()
        addAndConfigureCollection()
        addCloseGesture()
        
        presenter?.viewDidLoad()
    }

//    MARK: - UI configuration

    func addAndConfigureCollection() {
        collectionSupervisor = DetailCollectionSupervisor()
        collectionSupervisor?.delegate = self

        if let collectionView = collectionSupervisor?.getConfiguredCollection() {
            view.addSubview(collectionView)

            if let navigationBar = navigationBar {
                NSLayoutConstraint.activate([
                    collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                    collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20)
                ])
            }
        }
    }

    private func addAndConfigureNavigationBar() {
        let navigationBar = DefaultNavigationBar(title: "", backButtonTitle: "", backButtonImage: UIImage(named: "leftAccessory"))
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

    private func addCloseGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        gesture.direction = .right

        view.addGestureRecognizer(gesture)
    }

//    MARK: - UI update

    func updateContent(with model: DetailViewModel) {
        collectionSupervisor?.updateContent(with: model.detailCollectionModel)
        navigationBar?.update(with: model.defaultNavigationBarModel)
    }

    //    MARK: - User interaction

    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.location(in: view).x < GlobalConstants.xStartPointMaxValue {
            presenter?.userClosedModule()
        }
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
        presenter?.userClosedModule()
    }
}
