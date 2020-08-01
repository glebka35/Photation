//
//  CollectionProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - PRESENTER -> VIEW

protocol CollectionViewInput: AnyObject {
    var presenter: CollectionViewOutput? { get set }
    
    func updatePresentation(with style: PresentationStyle)
    func updateContent(with objects: [ObjectsOnImage])
}

//MARK: - VIEW -> PRESENTER

protocol CollectionViewOutput: AnyObject {
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
    
    func getObjects()
    func loadMoreObjects(completion: @escaping ()->Void)
}

//MARK:- INTERACTOR -> PRESENTER

protocol CollectionInteractorOutput: AnyObject {
    func objectsDidFetch(objects: [ObjectsOnImage])
}

//MARK:- PRESENTER -> ROUTER

protocol CollectionRouterInput: AnyObject {
    var view: CollectionView? { get set }

    func closeModule()
    func showDetail(of object: ObjectsOnImage)
}
