//
//  CollectionProtocols.swift
//  Photation
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

//MARK: - PRESENTER -> VIEW

protocol CollectionViewInput: AnyObject {
    var presenter: CollectionViewOutput? { get set }
    
    func updateContent(with model: CollectionViewModel)
    func clearSearchBar()
}

//MARK: - VIEW -> PRESENTER

protocol CollectionViewOutput: UISearchBarDelegate {
    var interactor: CollectionInteractorInput? { get set }
    var view: CollectionViewInput? { get set }
    var router: CollectionRouterInput? { get set }
    
    func viewDidLoad(with style: PresentationStyle)
    func changePresentation()
    func cellSelected(at indexPath: IndexPath)
    func scrollViewDidScrollToBottom()
}

//MARK: - PRESENTER -> INTERACTOR

protocol CollectionInteractorInput: AnyObject {
    var presenter: CollectionInteractorOutput? { get set }

    func viewDidLoad()
    func loadObjects()
}

//MARK:- INTERACTOR -> PRESENTER

protocol CollectionInteractorOutput: AnyObject {
    func objectsDidFetch(objects: [ObjectsOnImage])
    func updateNavigation(with navModel: MainNavigationBarModel)
    func deleteData()
}

//MARK:- PRESENTER -> ROUTER

protocol CollectionRouterInput: AnyObject {
    var view: CollectionView? { get set }

    func closeModule()
    func showDetail(of object: ObjectsOnImage)
}
