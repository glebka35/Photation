//
//  SpinnerViewController.swift
//  Photation
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

//    MARK: - Properties

    var spinner = UIActivityIndicatorView(style: .whiteLarge)

//    MARK: - Life cycle

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
