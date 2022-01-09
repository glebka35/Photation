//
//  FavoriteViewController.swift
//  Photation
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class FavoriteView: UIViewController, FavoriteViewInput {

//    MARK: - Constants

    enum Constants {
        static let navigationBarButtonFontSize: CGFloat = 22
    }

    //    MARK: - Properties

    var presenter: FavoriteViewOutput?

    private var navigationBar: MainNavigationBar?
    private var collectionSupervisor: CollectionViewSupervisorProtocol = CollectionViewSupervisor()

    //    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        addAndConfigureNavigationBar()
        addAndConfigureCollectionView()
        addAndConfigureDismissKeyboardTapGesture()

        presenter?.viewDidLoad()
    }

    //    MARK: - UI configuration

    private func addAndConfigureNavigationBar() {
        let rightButton = UIButton()
        rightButton.setTitle("", for: .normal)
        rightButton.setTitleColor(.blue, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.navigationBarButtonFontSize)

        let navigationBar = MainNavigationBar(title: "", rightButton: rightButton, isSearchBarNeeded: true)

        view.addSubview(navigationBar)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10),
            navigationBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 100)
        ])

        navigationBar.searchBarDelegate = presenter
        navigationBar.delegate = self

        self.navigationBar = navigationBar
        showRememberButton(bool: false)
    }

    private func addAndConfigureCollectionView() {
        let collectionView = collectionSupervisor.getConfiguredCollection()
        collectionSupervisor.delegate = self
        
        view.addSubview(collectionView)

        if let navigationBar = navigationBar {
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            ])
        }
    }

    private func addAndConfigureDismissKeyboardTapGesture() {
        let dismissTapGesture = UITapGestureRecognizer()
        dismissTapGesture.addTarget(self.view as Any, action: #selector(UIView.endEditing(_:)))
        dismissTapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissTapGesture)
    }

    //    MARK: - UI update
    
    func updateContent(with model: FavoriteViewModel) {
        if let tableModel = model.tableModel {
            collectionSupervisor.updateContent(with: tableModel)
        }
        navigationBar?.update(with: model.navigationBarModel)

        title = model.navigationBarModel.title
    }

    func showRememberButton(bool: Bool) {
        navigationBar?.showRightButton(bool: bool)
    }

    func clearSearchBar() {
        navigationBar?.clearSearchBar()
    }
}

//MARK: - CollectionViewActionsDelegate

extension FavoriteView: CollectionViewActionsDelegate {
    func cellSelected(at indexPath: IndexPath) {
        presenter?.cellSelected(at: indexPath)
    }

    func scrollViewDidScrollToBottom() {
        presenter?.scrollViewDidScrollToBottom()
    }
}

//MARK: - NavigationBarDelegate

extension FavoriteView: NavigationBarDelegate {
    func action(sender: UIButton!) {
        presenter?.openRememberGame()
    }
}
