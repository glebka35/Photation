//
//  TableStyleHeaderReusableView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 14.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class TableStyleHeaderReusableView: UICollectionReusableView {

//    MARK: - Properties

    private var nativeLanguageLabel = UILabel()
    private var foreignLanguageLabel = UILabel()

//    MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addAndConfigureLabels()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - UI configuration

    private func addAndConfigureLabels() {
        configure(label: nativeLanguageLabel)
        configure(label: foreignLanguageLabel)

        addSubview(nativeLanguageLabel)
        addSubview(foreignLanguageLabel)
    }

    private func configure(label: UILabel) {
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.5407631397, green: 0.5415609479, blue: 0.557064116, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
    }

    private func addConstraints() {
        nativeLanguageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nativeLanguageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nativeLanguageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        foreignLanguageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foreignLanguageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            foreignLanguageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

//    MARK: - UI update

    public func updateWith(nativeLanguage: String, foreignLanguage: String) {
        nativeLanguageLabel.text = nativeLanguage
        foreignLanguageLabel.text = foreignLanguage
    }
}
