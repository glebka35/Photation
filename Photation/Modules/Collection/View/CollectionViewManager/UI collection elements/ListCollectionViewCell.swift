//
//  ListCollectionViewCell.swift
//  Photation
//
//  Created by Gleb Uvarkin on 14.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell {

//    MARK: - Properties
    private var objectNativeLabel = UILabel()
    private var objectForeignLabel = UILabel()

//    MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9371728301, green: 0.937307477, blue: 0.9410645366, alpha: 1)
        
        addAndConfigureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - UI configuration

    private func addAndConfigureLabels() {
        configure(label: objectNativeLabel)
        configure(label: objectForeignLabel)
        
        let stackForLabels = UIStackView(arrangedSubviews: [objectNativeLabel, objectForeignLabel])
        
        stackForLabels.axis = .horizontal
        stackForLabels.alignment = .center
        stackForLabels.distribution = .equalCentering
        
        stackForLabels.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackForLabels)
        
        NSLayoutConstraint.activate([
            stackForLabels.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackForLabels.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackForLabels.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configure(label: UILabel) {
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.007841579616, green: 0.007844133303, blue: 0.007841020823, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }

//    MARK: - UI update
    
    public func updateStateWith(object: TableStyleObject) {
        objectNativeLabel.text = object.nativeName
        objectForeignLabel.text = object.foreignName
    }
}
