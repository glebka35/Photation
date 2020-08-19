//
//  RememberCollectionViewCell.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class RememberCollectionViewCell: UICollectionViewCell {

//    MARK: - Properties

    private var wordLabel = UILabel()

//    MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureCell()
        addAndConfigureLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - UI configuration

    private func configureCell() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        clipsToBounds = true
        backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
    }

    private func addAndConfigureLabel() {
        wordLabel.numberOfLines = 1
        wordLabel.textColor = .black
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)

        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wordLabel)

        NSLayoutConstraint.activate([
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            wordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            wordLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

//    MARK: - UI update

    func updateStateWith(text: String?, color: UIColor) {
        wordLabel.text = text
        layer.borderColor = color.cgColor
    }
    
}
