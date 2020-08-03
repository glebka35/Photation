//
//  DetailCollectionViewCell.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

//MARK: - IsWordFavorite enum

enum IsWordFavorite: CaseIterable{
    case yes, no

    var image: UIImage? {
        switch self {
        case .yes:
            return UIImage(named: "yes")
        case .no:
            return UIImage(named: "no")
        }
    }
}

//MARK: - DetailCollectionViewCell

class DetailCollectionViewCell: UICollectionViewCell {

//    MARK: - Properties

    private var objectNativeLabel = UILabel()
    private var objectForeignLabel = UILabel()
    private var favoriteImageView = UIImageView()

//    MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9371728301, green: 0.937307477, blue: 0.9410645366, alpha: 1)

        configureLabels()
        configureFavoriteImageView()
        embedInStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - UI configuration

    private func configureLabels() {
        configure(label: objectNativeLabel)
        configure(label: objectForeignLabel)
    }

    private func configure(label: UILabel) {
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.007841579616, green: 0.007844133303, blue: 0.007841020823, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }

    private func configureFavoriteImageView() {
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func embedInStack() {
        let hStack = UIStackView(arrangedSubviews: [objectNativeLabel, objectForeignLabel, favoriteImageView])

        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .equalCentering

        hStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hStack)

        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

//    MARK: - UI update

    func updateStateWith(object: SingleObject) {
           objectNativeLabel.text = object.nativeName
           objectForeignLabel.text = object.foreignName

           let image = object.isFavorite.image?.withRenderingMode(.alwaysTemplate)
           favoriteImageView.image = image
           favoriteImageView.tintColor = object.color
       }

}
