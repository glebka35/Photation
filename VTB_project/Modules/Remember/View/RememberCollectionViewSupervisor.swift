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

    private var variants: [String] = [] {
        didSet {
            correctIndecies = []
            wrongIndecies = []
        }
    }

    private var correctIndecies: [IndexPath] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private var wrongIndecies: [IndexPath] = [] {
        didSet {
            collectionView.reloadData()
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

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag

        return collectionView
    }

//    MARK: - UI update
    func update(with variants: [String]) {
        self.variants = variants
    }

    func emphasizeCorrectWord(at indexPath: IndexPath) {
        correctIndecies.append(indexPath)
    }

    func emphasizeWrongWord(at indexPath: IndexPath) {
        wrongIndecies.append(indexPath)
    }
}

//MARK: - UICollectionViewDataSource

extension RememberCollectionViewSupervisor: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        variants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rememberCell", for: indexPath) as? RememberCollectionViewCell {
            var color = Colors.none
            if correctIndecies.contains(indexPath) {
                color = Colors.correctChoice
            }
            if wrongIndecies.contains(indexPath) {
                color = Colors.wrongChoice
            }
            cell.updateStateWith(text: variants[indexPath.row], color: color)
            return cell
        }
        fatalError("Remember cell error")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension RememberCollectionViewSupervisor: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !wrongIndecies.contains(indexPath) && !correctIndecies.contains(indexPath) {
            delegate?.cellSelected(at: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2 * Constants.cellSideIndent - (Constants.numberOfCellInRow - 1) * Constants.cellPaddingSpace
        let widthPerItem = availableWidth / Constants.numberOfCellInRow
        return CGSize(width: widthPerItem, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.topSpacing, left: Constants.cellSideIndent, bottom: Constants.bottomSpacing, right: Constants.cellSideIndent)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellPaddingSpace
    }
}
