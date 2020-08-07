//
//  FavoriteViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class FavoriteView: UIViewController, FavoriteViewInput {
    var presenter: FavoriteViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        title = "Избранное"
    }
    
    func updateContent(with objects: [FavoriteObject]) {
        
    }

}
