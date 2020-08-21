//
//  ImageReusableView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 21.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class ImageReusableView: UICollectionReusableView {

    let imageView = UIImageView()

    func update(image: UIImage?) {
        imageView.image = image
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
            imageView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
