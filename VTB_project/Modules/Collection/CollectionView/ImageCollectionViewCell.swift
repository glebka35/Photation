//
//  ImageCollectionViewCell.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 07.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    private var objectImageView = UIImageView()
    private var objectForeignLabel = UILabel()
    
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
        objectForeignLabel.numberOfLines = 1
        objectForeignLabel.textColor = .white
        objectForeignLabel.textAlignment = .center
        objectForeignLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        
        objectForeignLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(objectForeignLabel)
        
        NSLayoutConstraint.activate([
            objectForeignLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            objectForeignLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            objectForeignLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func updateStateWith(image: ObjectsOnImage) {
        objectImageView.image = UIImage(data: image.image)
        objectForeignLabel.text = image.objects.first?.foreignName
    }
    
    private func setGradientToImage() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.6, 1]
        objectImageView.layer.insertSublayer(gradient, at: 0)
    }
}
