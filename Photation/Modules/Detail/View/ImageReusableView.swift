//
//  ImageReusableView.swift
//  Photation
//
//  Created by Gleb Uvarkin on 21.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class ImageReusableView: UICollectionReusableView {

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addAndConfigureImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(image: UIImage?) {
        imageView.image = image
        setNeedsLayout()
        layoutIfNeeded()
        layoutSubviews()
    }

    private func addAndConfigureImageView() {
        addSubview(imageView)

        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}
