//
//  CollectionViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit



class CollectionView: UIViewController, CollectionViewProtocol {
    var presenter: CollectionPresenterProtocol?
    
    private var collectionSupervisor: CollectionViewSupervisor = CollectionSupervisor()
    private var navigationBar: NavigationBar!
    
    private var currentStyle: PresentationStyle = .images

    override func viewDidLoad() {
        super.viewDidLoad()

        let assembly = CollectionAssembly()
        assembly.createCollectionModule(collectionRef: self)
        presenter?.viewDidLoad(with: currentStyle)

        view.backgroundColor = .white
        
        addAndConfigureNavigationBar()
        addAndConfigureCollectionView()
    }
    
    func addAndConfigureNavigationBar() {
        navigationBar = NavigationBar(title: "Коллекция", rightTitle: "English", rightButtonImage: UIImage(named: currentStyle.buttonImage), isSearchBarNeeded: true)
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = navigationBar.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            constraint
        ])
        
        let height = CGFloat(90) ///calculated height
        constraint.constant = height

        navigationBar.delegate = self
    }

    func addAndConfigureCollectionView() {
        let collectionView = collectionSupervisor.getConfiguredCollection(with: currentStyle)

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
    func rightAction(sender: UIButton!) {
        presenter?.changePresentation()
    }
}
