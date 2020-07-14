//
//  ImageCollectionViewCell.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 07.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class TranslatorCollectionViewCell: UICollectionViewCell {
    private var objectImageView = UIImageView()
    private var objectNativeLabel = UILabel()
    private var objectForeignLabel = UILabel()
    private var stackForLabels = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        
        setGradientToImage()
        addAndConfigureImageView()
        addAndConfigureLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateContentStyle()
    }
    
    private func addAndConfigureImageView() {
        objectImageView.contentMode = .scaleAspectFill
        objectImageView.translatesAutoresizingMaskIntoConstraints = false
        objectImageView.clipsToBounds = true
        objectImageView.layer.cornerRadius = 10

        addSubview(objectImageView)
        
        NSLayoutConstraint.activate([
            objectImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            objectImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            objectImageView.topAnchor.constraint(equalTo: topAnchor),
            objectImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addAndConfigureLabels() {
        configure(label: objectNativeLabel)
        configure(label: objectForeignLabel)
        
        stackForLabels.addArrangedSubview(objectNativeLabel)
        stackForLabels.addArrangedSubview(objectForeignLabel)
        
        stackForLabels.axis = .horizontal
        stackForLabels.alignment = .center
        stackForLabels.distribution = .equalCentering
        
        stackForLabels.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackForLabels)
        
        NSLayoutConstraint.activate([
            stackForLabels.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackForLabels.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackForLabels.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configure(label: UILabel) {
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.007841579616, green: 0.007844133303, blue: 0.007841020823, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    public func updateStateWith(image: ObjectsOnImage) {
        objectImageView.image = UIImage(data: image.image)
        objectForeignLabel.text = image.objects.first?.foreignName
        objectNativeLabel.text = image.objects.first?.nativeName
    }
    
    public func updateStateWith(object: SingleObject) {
        objectNativeLabel.text = object.nativeName
        objectForeignLabel.text = object.foreignName
    }
    
    private func setGradientToImage() {
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.6, 1]
        objectImageView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func updateContentStyle() {
        let isHorizontalStyle = bounds.width > 2 * bounds.height
        objectImageView.isHidden = isHorizontalStyle
        objectNativeLabel.isHidden = !isHorizontalStyle
        
        if isHorizontalStyle {
            objectForeignLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            objectForeignLabel.textColor = .black
        } else {
            objectForeignLabel.font = UIFont.systemFont(ofSize: 34, weight: .regular)
            objectForeignLabel.textColor = .white

        }
    
        setNeedsLayout()
    }
    
}
