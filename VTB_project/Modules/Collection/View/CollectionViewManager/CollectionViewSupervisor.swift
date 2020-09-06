//
//  CollectionManager.swift
//  HomeWork8
//
//  Created by Gleb Uvarkin on 05.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Collection view constants

enum CollectionSizes {
    static let numberOfCellInRow: CGFloat = 2
    static let cellSideIndent: CGFloat = 0
    static let cellPaddingSpace: CGFloat = 10
    static let topSpacing: CGFloat = 15
}

//MARK: - CollectionView supervisor protocol

protocol CollectionViewSupervisorProtocol {
    var styleDelegates: [PresentationStyle: CollectionViewDelegate] { get }
    var delegate: CollectionViewActionsDelegate? { get set }
    
    func getConfiguredCollection()->UICollectionView

    func updateContent(with imageModel: ImageStyleCollectionModel)
    func updateContent(with tableModel: TableStyleCollectionModel)
}

//MARK: - CollectionView supervisor

final class CollectionViewSupervisor: NSObject, CollectionViewSupervisorProtocol {

    //    MARK: - Properties

    weak var delegate: CollectionViewActionsDelegate? {
        didSet {
            styleDelegates.values.forEach {
                $0.delegate = delegate
            }
        }
    }

    var styleDelegates: [PresentationStyle: CollectionViewDelegate] = {
        let result: [PresentationStyle: CollectionViewDelegate] = [
            .table: TabledContentCollectionViewDelegate(),
            .images: ImagesContentCollectionViewDelegate()
        ]

        return result
    } ()

    private var collectionView: UICollectionView
    private var presentationStyle: PresentationStyle! {
        didSet {
            collectionView.delegate = styleDelegates[presentationStyle]
            if !(oldValue == presentationStyle) {
                animatedIndecies.removeAll()
            }
        }
    }

    private var imageModel: ImageStyleCollectionModel? {
        didSet {
            if imageModel?.objects.count == 0 {
                animatedIndecies.removeAll()
            }
            collectionView.reloadData()
        }
    }

    private var tableModel: TableStyleCollectionModel? {
        didSet {
            if imageModel?.objects.count == 0 {
                animatedIndecies.removeAll()
            }
            collectionView.reloadData()
        }
    }

    private var numberOfRows: Int {
        switch presentationStyle {
        case .images:
            return imageModel?.objects.count ?? 0
        case .table:
            return tableModel?.objects.count ?? 0
        case .none:
            return 0
        }
    }

    private var animatedIndecies: [IndexPath] = [] {
        didSet {
            
        }
    }

    //    MARK: - Life cycle
    
    override init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    //    MARK: - CollectionView configuration

    func getConfiguredCollection()->UICollectionView {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
        
        collectionView.register(TableStyleHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "tablePresentationHeader")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }

    //    MARK: - UI update

    func updateContent(with imageModel: ImageStyleCollectionModel) {
        presentationStyle = .images
        self.imageModel = imageModel
    }

    func updateContent(with tableModel: TableStyleCollectionModel) {
        presentationStyle = .table
        self.tableModel = tableModel
    }
}

//MARK: -  UICollectionViewDataSource

extension CollectionViewSupervisor: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImageCollectionViewCell, let imageWithObjects = imageModel?.objects[safelyAccess: indexPath.row] {
            cell.updateStateWith(object: imageWithObjects)
        }

        if let cell = cell as? ListCollectionViewCell, let object = tableModel?.objects[safelyAccess: indexPath.row] {
            cell.updateStateWith(object: object)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnCell: UICollectionViewCell!
        switch(presentationStyle) {
        case .images:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell {
                if let imageWithObjects = imageModel?.objects[safelyAccess: indexPath.row] {
                    cell.updateStateWith(object: imageWithObjects)
                }

                returnCell = cell
            }
        case .table:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCollectionViewCell {
                if let object = tableModel?.objects[safelyAccess: indexPath.row] {
                    cell.updateStateWith(object: object)
                }
                returnCell = cell
            }
        default:
            fatalError("Can't take a cell!")
        }

        animate(cell: returnCell, with: indexPath)

        return returnCell
    }

    private func animate(cell: UICollectionViewCell, with indexPath: IndexPath) {
        if  !animatedIndecies.contains(indexPath) {
            UIView.animate(withDuration: 0.5, delay: 20 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: indexPath.row % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {

                if indexPath.row % 2 == 0 {
                    AnimationUtility.viewSlideInFromLeft(toRight: cell)
                }
                else {
                    AnimationUtility.viewSlideInFromRight(toLeft: cell)
                }

            }, completion: { (done) in
                self.animatedIndecies.append(indexPath)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch(kind) {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "tablePresentationHeader", for: indexPath) as? TableStyleHeaderReusableView
                else {
                    fatalError("Invalid header view")
            }
            if let nativeLanguage = tableModel?.nativeLanguage, let foreignLanguage = tableModel?.foreignLanguage {
                headerView.updateWith(nativeLanguage: nativeLanguage, foreignLanguage: foreignLanguage)
            }

            return headerView
        default:
            assert(false, "Invalid element type")
            break
        }
    }

}
