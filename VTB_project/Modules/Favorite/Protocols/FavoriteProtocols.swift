//
//  FavoriteProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - PRESENTER -> VIEW

protocol FavoriteViewInput: AnyObject {
    var presenter: FavoriteViewOutput? { get set }

    func updateContent(with objects: [ObjectsOnImage])
}

//MARK: - VIEW -> PRESENTER

protocol FavoriteViewOutput: AnyObject {
    var interactor: FavoriteInteractorInput? { get set }
    var view: FavoriteViewInput? { get set }
    var router: FavoriteRouterInput? { get set }

    func viewDidLoad()
    func cellSelected(at indexPath: IndexPath)
    func scrollViewDidScrollToBottom()
}

//MARK: - PRESENTER -> INTERACTOR

protocol FavoriteInteractorInput: AnyObject {
    var presenter: FavoriteInteractorOutput? { get set }

    func viewDidLoad()
    func loadObjects()
}

//MARK:- INTERACTOR -> PRESENTER

protocol FavoriteInteractorOutput: AnyObject {
    func objectsDidFetch(objects: [ObjectsOnImage])
}

//MARK:- PRESENTER -> ROUTER

protocol FavoriteRouterInput: AnyObject {
    var view: FavoriteView? { get set }

    func showDetail(of object: ObjectsOnImage)
    func closeModule()
}

