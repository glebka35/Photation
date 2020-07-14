//
//  CollectionViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit



class CollectionViewController: UIViewController {
    
    private var collectionManager: CollectionViewManager?
    private let navigationBar = NavigationBar()
    private var presentationStyle: PresentationStyle = .images {
        didSet {
            updatePresentationStyle()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        addAndConfigureNavigationBar()
        addAndConfigureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    func addAndConfigureNavigationBar() {
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
        
        navigationBar.titleString = "Коллекция"
        navigationBar.rightTitleString = "English"
        navigationBar.rightButtonImage = UIImage(named: presentationStyle.buttonImage)
        navigationBar.delegate = self
    }

    func addAndConfigureCollectionView() {
        collectionManager = CollectionManager()
        
        guard let collectionView = collectionManager?.getConfiguredCollection(with: presentationStyle) else { return }

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        ])
    }
    
    private func updatePresentationStyle() {
        navigationBar.rightButtonImage = UIImage(named: presentationStyle.buttonImage)
        
        collectionManager?.updatePresentationStyle(with: presentationStyle)
    }
}

extension CollectionViewController: NavigationBarDelegate {
    func rightAction(sender: UIButton!) {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: presentationStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        presentationStyle = allCases[nextIndex]
    }
}
