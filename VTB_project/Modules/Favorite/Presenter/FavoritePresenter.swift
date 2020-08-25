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

    private var displayingObjects: [ObjectsOnImage] = []
    private var objectsAndImages: [ObjectsOnImage] = []
    private var filteredObjects: [ObjectsOnImage] = []
    private var isSearchActive = false

    //    MARK: - Life cycle

    func viewDidLoad() {
        displayingObjects = []
        objectsAndImages = []
        interactor?.viewDidLoad()
    }

    func cellSelected(at indexPath: IndexPath) {
        let object = isSearchActive ? filteredObjects[indexPath.row] : objectsAndImages[indexPath.row]
        router?.showDetail(of: object)
    }

    func scrollViewDidScrollToBottom() {
        interactor?.loadObjects()
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
            filteredObjects = displayingObjects.filter({ (imageWithObjects) -> Bool in
                var returnValue = false

                imageWithObjects.objects.forEach { (object) in
                    if let tmp = object.foreignName {
                        let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                        if range != nil {
                            returnValue = true
                            return
                        }
                    }

                    let tmp = object.nativeName
                    let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                    if range != nil {
                        returnValue = true
                        return
                    }
                }

                return returnValue
            })
        }

        view?.updateContent(with: filteredObjects)
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

        var objectsToDisplay: [ObjectsOnImage] = []

        if let nativeLanguage = self.objectsAndImages.first?.nativeLanguage, let foreignLanguage = self.objectsAndImages.first?.foreignLanguage, let date = self.objectsAndImages.first?.date {
            for i in 0..<objects.count {
                objectsToDisplay.append(ObjectsOnImage(image: images[i].image, objects: [objects[i]], date: date, nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage))
            }
        }

        displayingObjects.append(contentsOf: objectsToDisplay)

        view?.showRememberButton(bool: displayingObjects.count > 1)
        view?.updateContent(with: displayingObjects)

        view?.clearSearchBar()
        isSearchActive = false
    }

    func deleteData() {
        self.objectsAndImages = []
        self.displayingObjects = []


        view?.updateContent(with: [])
    }

    func languageChanged() {
        view?.languageChanged()
    }
}
