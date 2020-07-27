//
//  CollectionSupervisor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

protocol DetailCollectionSupervisorProtocol {
    var delegate: DetailCollectionSupervisorDelegate? { get set }
    func getConfiguredCollection()->UICollectionView
    func updateContent(with objects: [DetailObject])
}

protocol DetailCollectionSupervisorDelegate: AnyObject {
    func wordChosen(at index: Int)
}

class DetailCollectionSupervisor: NSObject, DetailCollectionSupervisorProtocol{
    private var collectionView: UICollectionView
    private var sectionInsets = UIEdgeInsets(top: CollectionSizes.topSpacing, left: CollectionSizes.cellSideIndent, bottom: 0, right: CollectionSizes.cellSideIndent)
    weak var delegate: DetailCollectionSupervisorDelegate?

    private var detailObjects: [DetailObject]

    required init(with objects: [DetailObject]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.detailObjects = objects
    }

    func getConfiguredCollection()->UICollectionView {
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "detailCell")

        collectionView.register(CollectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "detailCollectionHeader")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }

    func updateContent(with objects: [DetailObject]) {
        detailObjects = objects
        collectionView.reloadData()
    }
}

extension DetailCollectionSupervisor: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailObjects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as? DetailCollectionViewCell {
            cell.updateStateWith(object: detailObjects[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch(kind) {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "detailCollectionHeader", for: indexPath) as? CollectionHeaderReusableView
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

extension DetailCollectionSupervisor: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2 * CollectionSizes.cellSideIndent
        return CGSize(width: availableWidth, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2 * CollectionSizes.cellSideIndent
        return CGSize(width: availableWidth, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionSizes.cellPaddingSpace
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.wordChosen(at: indexPath.row)
    }
}
