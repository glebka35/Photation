//
//  CollectionProtocols.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

protocol CollectionViewProtocol: AnyObject {
//    PRESENTER -> VIEW
    var presenter: CollectionPresenterProtocol? { get set }
    
    func updatePresentation(with style: PresentationStyle)
    func updateContent(with objects: [ObjectsOnImage])
}

protocol CollectionPresenterProtocol: AnyObject {
//    VIEW -> PRESENTER
    var interactor: CollectionInputInteractorProtocol? { get set }
    var view: CollectionViewProtocol? { get set }
    var wireframe: CollectionWireFrameProtocol? { get set }
    
    func viewDidLoad(with style: PresentationStyle)
    func changePresentation()
}

protocol CollectionInputInteractorProtocol: AnyObject {
//    PRESENTER -> INTERACTOR
    var presenter: CollectionOutputInteractorProtocol? { get set }
    
    func getObjects()
}

protocol CollectionOutputInteractorProtocol: AnyObject {
//    INTERACTOR -> PRESENTER
    func objectsDidFetch(objects: [ObjectsOnImage])
    
}

protocol CollectionWireFrameProtocol: AnyObject {
//    PRESENTER -> WIREFRAME
    
    static func createCollectionModule(collectionRef: CollectionView)
}
