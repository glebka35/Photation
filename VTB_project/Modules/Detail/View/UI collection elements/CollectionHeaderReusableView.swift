//
//  CollectionHeaderReusableView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class CollectionHeaderReusableView: UICollectionReusableView {
    private var nativeLanguageLabel = UILabel()
    private var foreignLanguageLabel = UILabel()
    private var favoriteImageView = UIImageView(image: UIImage(named: "heart"))

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        configureLabels()
        embedInStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateWith(nativeLanguage: String, foreignLanguage: String) {
        nativeLanguageLabel.text = nativeLanguage
        foreignLanguageLabel.text = foreignLanguage
    }

    private func configureLabels() {
        configure(label: nativeLanguageLabel)
        configure(label: foreignLanguageLabel)
    }


    private func configure(label: UILabel) {
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.5407631397, green: 0.5415609479, blue: 0.557064116, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
    }

    private func embedInStack() {
        let hStack = UIStackView(arrangedSubviews: [nativeLanguageLabel, foreignLanguageLabel, favoriteImageView])
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(hStack)

        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
