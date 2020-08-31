//
//  CollectionViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, CollectionViewInput {

//    MARK: - Properties

    var presenter: CollectionViewOutput?
    
    private var collectionSupervisor: CollectionViewSupervisorProtocol = CollectionViewSupervisor()
    private var navigationBar: MainNavigationBar!
    private var currentStyle: PresentationStyle = .images

//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        addAndConfigureNavigationBar()
        addAndConfigureCollectionView()
        addAndConfigureDismissKeyboardTapGesture()

        presenter?.viewDidLoad(with: currentStyle)
    }

//    MARK: - UI configuration
    
    private func addAndConfigureNavigationBar() {

        let rightBarButton = UIButton()
        rightBarButton.setImage(UIImage(named: currentStyle.buttonImage), for: .normal)
        navigationBar = MainNavigationBar(title: LocalizedString().collection, rightTitle: SettingsStore.shared.getForeignLanguage().humanRepresentingNative, rightButton: rightBarButton, isSearchBarNeeded: true)

        view.addSubview(navigationBar)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10),
            navigationBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 100)
        ])

        navigationBar.delegate = self
        navigationBar.searchBarDelegate = presenter
    }

    private func addAndConfigureCollectionView() {
        let collectionView = collectionSupervisor.getConfiguredCollection()
        collectionSupervisor.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        ])
    }

    private func addAndConfigureDismissKeyboardTapGesture() {
        let dismissTapGesture = UITapGestureRecognizer()
        dismissTapGesture.addTarget(self.view as Any, action: #selector(UIView.endEditing(_:)))
        dismissTapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissTapGesture)
    }

//    MARK: - UI update

    func updateContent(with model: CollectionViewModel) {

        if let imageModel = model.imageModel {
            collectionSupervisor.updateContent(with: imageModel)
            currentStyle = PresentationStyle.images
        } else if let tableModel = model.tableModel {

            collectionSupervisor.updateContent(with: tableModel)
            currentStyle = PresentationStyle.table
        }

        navigationBar.update(with: model.navigationBarModel)
        navigationBar.rightButtonImage = UIImage(named: currentStyle.buttonImage)

        title = model.navigationBarModel.title
    }

    func clearSearchBar() {
        navigationBar.clearSearchBar()
    }
}

//MARK: - NavigationBar delegate

extension CollectionView: NavigationBarDelegate {
    func action(sender: UIButton!) {
        presenter?.changePresentation()
    }
}

//MARK: - CollectionView actions delegate

extension CollectionView: CollectionViewActionsDelegate {
    func scrollViewDidScrollToBottom() {
        presenter?.scrollViewDidScrollToBottom()
    }

    func cellSelected(at indexPath: IndexPath) {
        presenter?.cellSelected(at: indexPath)
    }
}
