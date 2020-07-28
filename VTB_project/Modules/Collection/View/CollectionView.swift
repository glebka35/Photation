//
//  CollectionViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, CollectionViewInput {
    var presenter: CollectionViewOutput?
    
    private var collectionSupervisor: CollectionViewSupervisor = CollectionSupervisor()
    private var navigationBar: MainNavigationBar!
    
    private var currentStyle: PresentationStyle = .images

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad(with: currentStyle)

        view.backgroundColor = .white
        
        addAndConfigureNavigationBar()
        addAndConfigureCollectionView()
    }
    
    func addAndConfigureNavigationBar() {
        navigationBar = MainNavigationBar(title: "Коллекция", rightTitle: UserSettings.shared.foreignLanguage.humanRepresenting, rightButtonImage: UIImage(named: currentStyle.buttonImage), isSearchBarNeeded: true)
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 90)
        ])

        navigationBar.delegate = self
    }

    func addAndConfigureCollectionView() {
        let collectionView = collectionSupervisor.getConfiguredCollection(with: currentStyle)
        collectionSupervisor.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        ])
    }
    
    func updatePresentation(with style: PresentationStyle) {
        navigationBar.rightButtonImage = UIImage(named: style.buttonImage)
        collectionSupervisor.updatePresentationStyle(with: style)
        currentStyle = style
    }
    
    func updateContent(with objects: [ObjectsOnImage]) {
        collectionSupervisor.objects = objects
    }
}

extension CollectionView: NavigationBarDelegate {
    func action(sender: UIButton!) {
        presenter?.changePresentation()
    }
}

extension CollectionView: CollectionViewCellSelectedDelegate {
    func cellSelected(at indexPath: IndexPath) {
        presenter?.cellSelected(at: indexPath)
    }
}