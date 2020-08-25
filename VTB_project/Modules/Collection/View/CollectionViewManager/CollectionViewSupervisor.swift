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
        }
    }

    private var imageModel: ImageStyleCollectionModel? {
        didSet {
            collectionView.reloadData()
        }
    }

    private var tableModel: TableStyleCollectionModel? {
        didSet {
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch(presentationStyle) {
        case .images:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell {
                if let imageWithObjects = imageModel?.objects[indexPath.row] {
                    cell.updateStateWith(object: imageWithObjects)
                }
                return cell
            }
        case .table:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCollectionViewCell {
                if let object = tableModel?.objects[indexPath.row] {
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
            headerView.updateWith(nativeLanguage: SettingsStore.shared.getNativeLanguage().humanRepresentingNative, foreignLanguage: SettingsStore.shared.getForeignLanguage().humanRepresentingNative)
            return headerView
        default:
            assert(false, "Invalid element type")
            break
        }
    }
}
