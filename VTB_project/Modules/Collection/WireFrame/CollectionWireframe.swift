//
//  CollectionWireframe.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class CollectionWireFrame: CollectionWireFrameProtocol {
    static func createCollectionModule(collectionRef: CollectionView) {
        let presenter: CollectionPresenterProtocol & CollectionOutputInteractorProtocol = CollectionPresenter()
        
        collectionRef.presenter = presenter
        collectionRef.presenter?.wireframe = CollectionWireFrame()
        collectionRef.presenter?.view = collectionRef
        collectionRef.presenter?.interactor = CollectionInteractor()
        collectionRef.presenter?.interactor?.presenter = presenter
    }
}
