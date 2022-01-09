//
//  CollectionViewDelegatesFlowLayout.swift
//  Photation
//
//  Created by Gleb Uvarkin on 10.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - CollectionView delegate

protocol CollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    var delegate: CollectionViewActionsDelegate? { get set }
}

//MARK: - DefaultCollectionView delegate

class DefaultCollectionViewDelegate: NSObject, CollectionViewDelegate {

//    MARK: - Properties

    var delegate: CollectionViewActionsDelegate?
    var sectionInsets = UIEdgeInsets(top: CollectionSizes.topSpacing, left: CollectionSizes.cellSideIndent, bottom: 0, right: CollectionSizes.cellSideIndent)

//    MARK: - Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellSelected(at: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            delegate?.scrollViewDidScrollToBottom()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionSizes.cellPaddingSpace
    }
}

//MARK: - TabledCollectionView delegate

final class TabledContentCollectionViewDelegate: DefaultCollectionViewDelegate {
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
}

//MARK: - ImagesCollectionView delegate

final class ImagesContentCollectionViewDelegate: DefaultCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2 * CollectionSizes.cellSideIndent - (CollectionSizes.numberOfCellInRow - 1) * CollectionSizes.cellPaddingSpace
        let widthPerItem = availableWidth / CollectionSizes.numberOfCellInRow
        return CGSize(width: widthPerItem, height: 1.3 * widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionSizes.cellPaddingSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

