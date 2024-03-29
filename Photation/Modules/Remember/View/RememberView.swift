//
//  RememberView.swift
//  Photation
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class RememberView: UIViewController, RememberViewInput {

    //    MARK: - Properties

    var presenter: RememberViewOutput?

    private var navigationBar: DefaultNavigationBar?
    private var header = RememberHeaderView()
    private var footer = RememberFooterView()
    private var collectionSupervisor = RememberCollectionViewSupervisor()

    private var isUserInteractionEnable = true

    //    MARK: - Life cycle

    override func viewDidLoad() {
        view.backgroundColor = .white
        
        addAndConfigureNavigationBar()
        addAndConfigureHeader()
        addAndConfigureCollectionView()
        addAndConfigureFooter()

        presenter?.viewDidLoad()
    }

    //    MARK: - UI configuration

    private func addAndConfigureHeader() {
        header.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(header)

        if let navigationBar = navigationBar {
            NSLayoutConstraint.activate([
                header.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
                header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                header.heightAnchor.constraint(equalToConstant: 130)
            ])
        }
    }

    private func addAndConfigureFooter() {
        footer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(footer)

        NSLayoutConstraint.activate([
            footer.topAnchor.constraint(equalTo: collectionSupervisor.collectionView.bottomAnchor),
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footer.heightAnchor.constraint(equalToConstant: 100)
        ])


        footer.delegate = self
    }

    private func addAndConfigureNavigationBar() {
        let navigationBar = DefaultNavigationBar(title: LocalizedString().remember, backButtonTitle: LocalizedString().backButton, backButtonImage: UIImage(named: "leftAccessory"))
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

    private func addAndConfigureCollectionView() {
        let collectionView = collectionSupervisor.getConfiguredCollection()
        collectionSupervisor.delegate = self
        collectionSupervisor.footerDelegate = self
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(lessThanOrEqualTo: header.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 180)
        ])

        collectionSupervisor.delegate = self
    }

    //    MARK: - UI update

    func update(with model: RememberViewModel) {
        navigationBar?.update(with: model.navigationBarModel)
        collectionSupervisor.update(with: model.gameModel.variants)
        header.update(with: model.gameModel.mainWord)
        footer.update(with: model.footerModel)
    }

    func update(footer: FooterModel) {
        self.footer.update(with: footer)
    }

    

    func emphasizeCorrectWord(at indexPath: IndexPath) {
        collectionSupervisor.emphasizeCorrectWord(at: indexPath)
        isUserInteractionEnable = false
    }

    func emphasizeWrongWord(at indexPath: IndexPath) {
        collectionSupervisor.emphasizeWrongWord(at: indexPath)
    }

    func showNextButton() {
        footer.hideNextButton(bool: false)
    }

    func hideNextButton() {
        footer.hideNextButton(bool: true)
    }
}

//    MARK: - User interaction

extension RememberView: FooterActionDelegate {
    func performAction() {
        presenter?.nextButtonPressed()
        isUserInteractionEnable = true
        collectionSupervisor.resetEmphasizedWords()
    }
}

//MARK: - NavigationBarDelegate

extension RememberView: NavigationBarDelegate {
    func action(sender: UIButton!) {
        presenter?.backButtonPressed()
    }
}

//MARK: - CollectionViewActionsDelegate

extension RememberView: CollectionViewActionsDelegate {
    func cellSelected(at indexPath: IndexPath) {
        if isUserInteractionEnable {
            presenter?.wordChosen(at: indexPath)
        }
    }
}
