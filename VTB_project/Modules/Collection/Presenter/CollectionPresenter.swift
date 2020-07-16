//
//  CollectionPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class CollectionPresenter: CollectionPresenterProtocol {
    var interactor: CollectionInputInteractorProtocol?
    weak var view: CollectionViewProtocol?
    var wireframe: CollectionWireFrameProtocol?
    
    private var currentStyle: PresentationStyle!
    
    func viewDidLoad(with style: PresentationStyle) {
        currentStyle = style
        interactor?.getObjects()
    }
    
    func changePresentation() {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: currentStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        let newStyle = allCases[nextIndex]
        currentStyle = newStyle
        interactor?.getObjects()
        view?.updatePresentation(with: newStyle)
    }
}

extension CollectionPresenter: CollectionOutputInteractorProtocol {
    func objectsDidFetch(objects: [ObjectsOnImage]) {
        var objectsToDisplay = [ObjectsOnImage]()
        
        switch(currentStyle) {
        case .images:
            objectsToDisplay = objects
        case .table:
            var singleObjects = [SingleObject]()
            objects.forEach { singleObjects.append(contentsOf: $0.objects) }
            singleObjects.forEach { objectsToDisplay.append(ObjectsOnImage(image: Data(), objects: [$0], nativeLanguage: objects[0].nativeLanguage, foreignLanguage: objects[0].foreignLanguage))}
        default:
            break
        }
        
        view?.updateContent(with: objectsToDisplay)
    }
}

