//
//  CollectionPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 16.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

//MARK: - CollectionViewOutput

class CollectionPresenter: NSObject, CollectionViewOutput {

    //    MARK: - Properties

    var interactor: CollectionInteractorInput?
    weak var view: CollectionViewInput?
    var router: CollectionRouterInput?

    private var objects: [ObjectsOnImage] = [] {
        didSet {
            nativeLanguage = self.objects.first?.nativeLanguage.humanRepresentingNative ?? ""
            foreignLanguage = self.objects.first?.foreignLanguage.humanRepresentingNative ?? ""
            updateData()
        }
    }
    private var navigationBarModel: MainNavigationBarModel?
    private var nativeLanguage:String = ""
    private var foreignLanguage: String = ""
    private var filteredObjects: [ObjectsOnImage] = []
    private var currentStyle: PresentationStyle! {
        didSet {
            updateData()
        }
    }
    private var currentViewModel: CollectionViewModel?
    private var isSearchActive = false
    
    private var dataConverter: ObjectToImageViewConverterProtocol & ObjectToTableViewConverterProtocol = CollectionViewDataConverter()

    //    MARK: - UI life cycle
    func viewDidLoad(with style: PresentationStyle) {
        currentStyle = style
        interactor?.viewDidLoad()
    }

    //    MARK: - UI update
    
    func changePresentation() {
        let allCases = PresentationStyle.allCases
        guard let index = allCases.firstIndex(of: currentStyle) else { return }
        let nextIndex = (index + 1) % allCases.count
        let newStyle = allCases[nextIndex]
        currentStyle = newStyle

        view?.clearSearchBar()
        isSearchActive = false
    }

    func cellSelected(at indexPath: IndexPath) {
        var object: ObjectsOnImage?

        switch currentStyle {
        case .images:
            if let viewObject = currentViewModel?.imageModel?.objects[safelyAccess: indexPath.row] {
                object = objects.first(where: { (image) -> Bool in
                    image.date == viewObject.id
                })
            }
        case .table:
            if let viewObject = currentViewModel?.tableModel?.objects[safelyAccess: indexPath.row] {
                object = objects.first(where: { (image) -> Bool in
                    image.date == viewObject.id
                })
            }
        case .none:
            return
        }

        if let object = object {
            router?.showDetail(of: object)
        }

    }

    func scrollViewDidScrollToBottom() {
        interactor?.loadObjects()
    }

    private func updateData() {
        DispatchQueue.global(qos: .userInitiated).async {
            var objectsToDisplay: [ObjectsOnImage]!

            if self.isSearchActive {
                objectsToDisplay = self.filteredObjects
            } else {
                objectsToDisplay = self.objects
            }
            if let navBarModel = self.currentViewModel?.navigationBarModel {
                var model: CollectionViewModel?
                var imageModel: ImageStyleCollectionModel?
                var tableModel: TableStyleCollectionModel?

                switch self.currentStyle {
                case .images:
                    let imageObjects = self.dataConverter.convertToImage(from: objectsToDisplay)
                    imageModel = ImageStyleCollectionModel(objects: imageObjects)

                case .table:
                    let tableObjects = self.dataConverter.convertToTable(from: objectsToDisplay)
                    tableModel = TableStyleCollectionModel(nativeLanguage: self.nativeLanguage, foreignLanguage: self.foreignLanguage, objects: tableObjects)

                default:
                    return
                }

                model = CollectionViewModel(navigationBarModel: navBarModel, imageModel: imageModel, tableModel: tableModel)
                if let model = model {
                    DispatchQueue.main.async {
                        self.view?.updateContent(with: model)
                        self.currentViewModel = model
                    }
                }
            }

        }
    }
}

//MARK: - CollectionInteractorOutput

extension CollectionPresenter: CollectionInteractorOutput {
    func objectsDidFetch(objects: [ObjectsOnImage]) {
        self.objects.append(contentsOf: objects)
    }

    func deleteData() {
        view?.clearSearchBar()
        self.objects = []
    }

    func updateNavigation(with navModel: MainNavigationBarModel) {
        view?.clearSearchBar()
        let model = CollectionViewModel(navigationBarModel: navModel, imageModel: currentViewModel?.imageModel, tableModel: currentViewModel?.tableModel)
        view?.updateContent(with: model)
        self.currentViewModel = model
    }

}

//MARK: - UISearchBarDelegate

extension CollectionPresenter: UISearchBarDelegate {

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
            filteredObjects = objects
            isSearchActive = false
        } else {
            isSearchActive = true
            filteredObjects = objects.filter({ (imageWithObjects) -> Bool in
                var returnValue = false

                imageWithObjects.objects.forEach { (object) in

                    let rangeForeign = object.foreignName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                    if rangeForeign != nil {
                        returnValue = true
                        return
                    }

                    let tmp = object.nativeName
                    let rangeNative = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                    if rangeNative != nil {
                        returnValue = true
                        return
                    }
                }
                return returnValue
            })
        }
        updateData()
    }
}
