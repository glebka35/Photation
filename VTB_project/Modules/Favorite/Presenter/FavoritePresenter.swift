//
//  FavoritePresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 06.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class FavoritePresenter: NSObject, FavoriteViewOutput {
    
    //    MARK: - Properties
    
    var interactor: FavoriteInteractorInput?
    weak var view: FavoriteViewInput?
    var router: FavoriteRouterInput?
    
    private var displayingObjects: [SingleObject] = [] {
        didSet {
            nativeLanguage = objectsAndImages.first?.nativeLanguage.humanRepresentingNative ?? ""
            foreignLanguage = objectsAndImages.first?.foreignLanguage.humanRepresentingNative ?? ""
            updateData()
        }
    }
    private var objectsAndImages: [ObjectsOnImage] = []
    private var filteredObjects: [SingleObject] = [] {
        didSet {
            updateData()
        }
    }
    
    private var currentViewModel: FavoriteViewModel?
    private var navigationBarModel: MainNavigationBarModel?
    private var nativeLanguage: String = ""
    private var foreignLanguage: String = ""
    private var dataConverter: SingleObjectsToTableViewConverterProtocol = SingleObjectsToTableViewConverter()
    private var isSearchActive = false
    
    //    MARK: - Life cycle
    
    func viewDidLoad() {
        displayingObjects = []
        objectsAndImages = []
        interactor?.viewDidLoad()
    }
    
    func cellSelected(at indexPath: IndexPath) {
        let object = currentViewModel?.tableModel?.objects[indexPath.row]
        let displayingObject = objectsAndImages.first { (image) -> Bool in
            image.date == object?.id
        }
        if let objectToDetail = displayingObject {
            router?.showDetail(of: objectToDetail)
        }
    }
    
    func scrollViewDidScrollToBottom() {
        interactor?.loadObjects()
    }
    
    //    MARK: - UI update
    
    private func updateData() {
        let objectsToDisplay: [SingleObject]!
        
        if isSearchActive {
            objectsToDisplay = filteredObjects
        } else {
            objectsToDisplay = displayingObjects
        }
        if let navBarModel = navigationBarModel {
            let tableObjects = dataConverter.convertToTable(from: objectsToDisplay, and: objectsAndImages)
            let tableModel = TableStyleCollectionModel(nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage, objects: tableObjects)
            let model = FavoriteViewModel(navigationBarModel: navBarModel, tableModel: tableModel)
            
            view?.updateContent(with: model)
            self.currentViewModel = model
            
            view?.showRememberButton(bool: tableModel.objects.count > 1)
        }
        
        isSearchActive = false
    }
}

//MARK: - UISearchBarDelegate

extension FavoritePresenter: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredObjects = displayingObjects
            isSearchActive = false
        } else {
            isSearchActive = true
            filteredObjects = displayingObjects.filter({ (object) -> Bool in
                
                
                let rangeForeign = object.foreignName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                if rangeForeign != nil {
                    return true
                }
                
                
                let tmp = object.nativeName
                let rangeNative = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                if rangeNative != nil {
                    return true
                }
                
                return false
            })
        }
    }
    
    //    MARK: - Navigation
    
    func openRememberGame() {
        router?.showRememberGame(with: displayingObjects)
        
        view?.clearSearchBar()
        isSearchActive = false
    }
}

//MARK: - FavoriteInteractorOutput

extension FavoritePresenter: FavoriteInteractorOutput {
    func objectsDidFetch(images: [ObjectsOnImage], objects: [SingleObject]) {
        self.objectsAndImages.append(contentsOf: images)
        self.displayingObjects.append(contentsOf: objects)
    }
    
    func deleteData() {
        view?.clearSearchBar()
        self.objectsAndImages = []
        self.displayingObjects = []
    }
    
    func updateNavigation(with navModel: MainNavigationBarModel) {
        view?.clearSearchBar()
        let model = FavoriteViewModel(navigationBarModel: navModel, tableModel: currentViewModel?.tableModel)
        view?.updateContent(with: model)
        self.currentViewModel = model
        self.navigationBarModel = navModel
    }
}
