//
//  FavoriteViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class FavoriteView: UIViewController, FavoriteViewInput {

    //    MARK: - Properties

    var presenter: FavoriteViewOutput?

    private var navigationBar: MainNavigationBar!
    private var collectionSupervisor: CollectionViewSupervisorProtocol = CollectionViewSupervisor()

    //    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        addAndConfigureNavigationBar()
        addAndConfigureCollectionView()

        presenter?.viewDidLoad()
    }

    //    MARK: - UI configuration

    private func addAndConfigureNavigationBar() {
        navigationBar = MainNavigationBar(title: "Избранное", rightTitle: UserSettings.shared.foreignLanguage.humanRepresentingNative, isSearchBarNeeded: true)

        view.addSubview(navigationBar)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 90)
        ])
    }

    private func addAndConfigureCollectionView() {
        let collectionView = collectionSupervisor.getConfiguredCollection(with: .table)
        collectionSupervisor.delegate = self
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        ])
    }

    //    MARK: - UI update
    
    func updateContent(with objects: [ObjectsOnImage]) {
        collectionSupervisor.updateContent(with: objects)
    }

}

extension FavoriteView: CollectionViewActionsDelegate {
    func cellSelected(at indexPath: IndexPath) {
        presenter?.cellSelected(at: indexPath)
    }

    func scrollViewDidScrollToBottom() {
        presenter?.scrollViewDidScrollToBottom()
    }

    
}
