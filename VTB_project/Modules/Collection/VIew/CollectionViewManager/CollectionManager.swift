//
//  CollectionManager.swift
//  HomeWork8
//
//  Created by Gleb Uvarkin on 05.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

struct CollectionSizes {
    static let numberOfCellInRow: CGFloat = 2
    static let cellSideIndent: CGFloat = 8
    static let cellPaddingSpace: CGFloat = 10
    static let topSpacing: CGFloat = 15
}

protocol CollectionViewManager {
    var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] { get }
    var objects: [ObjectsOnImage] { get set }
    
    func getConfiguredCollection(with style: PresentationStyle)->UICollectionView
    func updatePresentationStyle(with style: PresentationStyle)
}

class CollectionManager: NSObject, CollectionViewManager {
    private var collectionView: UICollectionView
    public var objects = [ObjectsOnImage]()
    
    private var numberOfRows: Int {
        return objects.count
    }
    
    private var presentationStyle: PresentationStyle!
    
    override init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    public var styleDelegates: [PresentationStyle: CollectionViewSelectableItemDelegate] = {
        let result: [PresentationStyle: CollectionViewSelectableItemDelegate] = [
            .table: TabledContentCollectionViewDelegate(),
            .images: ImagesContentCollectionViewDelegate()
        ]
        result.values.forEach {
            $0.didSelectItem = { _ in
                print("Item selected")
            }
        }
        return result
    } ()
    
    public func getConfiguredCollection(with style: PresentationStyle)->UICollectionView {
        
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
        
        collectionView.register(TableStyleHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "tablePresentationHeader")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        collectionView.delegate = styleDelegates[style]
        collectionView.dataSource = self
        
        presentationStyle = style
        return collectionView
    }
    
    public func updatePresentationStyle(with style: PresentationStyle) {
        presentationStyle = style
        collectionView.delegate = styleDelegates[style]
        collectionView.reloadData()
    }
}

extension CollectionManager: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch(presentationStyle) {
        case .images:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell {
                let imageWithObjects = objects[indexPath.row]
                cell.updateStateWith(image: imageWithObjects)
                return cell
            }
        case .table:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCollectionViewCell {
                if let object = objects[indexPath.row].objects.first {
                    cell.updateStateWith(object: object)
                }
                
                return cell
            }
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch(kind) {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "tablePresentationHeader", for: indexPath) as? TableStyleHeaderReusableView
                else {
                    fatalError("Invalid header view")
            }
            headerView.updateWith(nativeLanguage: "Русский", foreignLanguage: "English")
            return headerView
        default:
            assert(false, "Invalid element type")
            break
        }
    }
}
