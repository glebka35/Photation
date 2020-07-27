//
//  CollectionProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

protocol CollectionViewInput: AnyObject {
//    PRESENTER -> VIEW
    var presenter: CollectionViewOutput? { get set }
    
    func updatePresentation(with style: PresentationStyle)
    func updateContent(with objects: [ObjectsOnImage])
}

protocol CollectionViewOutput: AnyObject {
//    VIEW -> PRESENTER
    var interactor: CollectionInteractorInput? { get set }
    var view: CollectionViewInput? { get set }
    var router: CollectionRouterInput? { get set }
    
    func viewDidLoad(with style: PresentationStyle)
    func changePresentation()
}

protocol CollectionInteractorInput: AnyObject {
//    PRESENTER -> INTERACTOR
    var presenter: CollectionInteractorOutput? { get set }
    
    func getObjects()
}

protocol CollectionInteractorOutput: AnyObject {
//    INTERACTOR -> PRESENTER
    func objectsDidFetch(objects: [ObjectsOnImage])
}

protocol CollectionRouterInput: AnyObject {
//    PRESENTER -> ROUTER
    var view: CollectionView? { get set }

    func closeModule()
}
