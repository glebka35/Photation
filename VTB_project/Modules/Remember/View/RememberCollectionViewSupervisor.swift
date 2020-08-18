//
//  RememberCollectionViewSupervisor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class RememberCollectionViewSupervisor: NSObject {

//    MARK: - Constants

    enum Constants {
        static let numberOfCellInRow: CGFloat = 2
        static let cellSideIndent: CGFloat = 50
        static let cellPaddingSpace: CGFloat = 15
        static let topSpacing: CGFloat = 70
        static let bottomSpacing: CGFloat = 70
    }

    enum Colors {
        static let correctChoice = UIColor.green
        static let wrongChoice = UIColor.red
        static let none = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

    //    MARK: - Properties

    private var collectionView: UICollectionView

    weak var delegate: CollectionViewActionsDelegate?
    weak var footerDelegate: FooterActionDelegate?

    private var gameModel: RememberGameModel? {
        didSet {
            correctIndex = nil
            wrongIndex = nil
            collectionView.reloadSections(IndexSet([0]))
        }
    }

    private var correctIndex: IndexPath? {
        didSet {
            if let indexPath = correctIndex {
                collectionView.reloadItems(at: [indexPath])
            } else {
                if let indexPath = oldValue {
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }

    private var wrongIndex: IndexPath? {
        didSet {
            if let indexPath = wrongIndex {
                collectionView.reloadItems(at: [indexPath])
            } else {
                if let indexPath = oldValue {
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }

    var isNextButtonHidden: Bool = true {
        didSet {
            collectionView.reloadSections(IndexSet([0]))
//            collectionView.setNeedsLayout()
//            collectionView.setNeedsDisplay()
//            collectionView.layoutIfNeeded()
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
        collectionView.register(RememberCollectionViewCell.self, forCellWithReuseIdentifier: "rememberCell")

        collectionView.register(MainWordHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "mainWordHeader")
        collectionView.register(RememberFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "rememberFooter")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag

        return collectionView
    }

//    MARK: - UI update
    func update(with gameModel: RememberGameModel) {
        self.gameModel = gameModel
    }

    func emphasizeCorrectWord(at indexPath: IndexPath) {
        correctIndex = indexPath
    }

    func emphasizeWrongWord(at indexPath: IndexPath) {
        wrongIndex = indexPath
    }
}

//MARK: - UICollectionViewDataSource

extension RememberCollectionViewSupervisor: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameModel?.variants.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rememberCell", for: indexPath) as? RememberCollectionViewCell {
            var color = Colors.none
            if indexPath == correctIndex {
                color = Colors.correctChoice
            }
            if indexPath == wrongIndex {
                color = Colors.wrongChoice
            }
            cell.updateStateWith(text: gameModel?.variants[indexPath.row], color: color)
            return cell
        }
        fatalError("Remember cell error")
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch(kind) {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainWordHeader", for: indexPath) as? MainWordHeaderReusableView
                else {
                    fatalError("Invalid header view")
            }
            headerView.update(with: gameModel?.mainWord)
            return headerView

        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "rememberFooter", for: indexPath) as? RememberFooterReusableView
                else {
                    fatalError("Invalid header view")
            }

            if let gameModel = gameModel {
                footerView.update(with: gameModel.footerModel, isNextButtonHidden: isNextButtonHidden)
            }
            footerView.delegate = footerDelegate
            return footerView
        default:
            assert(false, "Invalid element type")
            break
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension RememberCollectionViewSupervisor: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellSelected(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2 * Constants.cellSideIndent - (Constants.numberOfCellInRow - 1) * Constants.cellPaddingSpace
        let widthPerItem = availableWidth / Constants.numberOfCellInRow
        return CGSize(width: widthPerItem, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.topSpacing, left: Constants.cellSideIndent, bottom: Constants.bottomSpacing, right: Constants.cellSideIndent)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2 * Constants.cellSideIndent
        return CGSize(width: availableWidth, height: 130)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2 * Constants.cellSideIndent
        return CGSize(width: availableWidth, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellPaddingSpace
    }
}
