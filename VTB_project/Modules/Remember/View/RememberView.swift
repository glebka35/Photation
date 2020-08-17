//
//  RememberView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 17.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class RememberView: UIViewController, RememberViewInput {

//    MARK: - Properties

    var presenter: RememberViewOutput?

//    MARK: - Life cycle

    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }

//    MARK: - UI update

    func update(with gameModel: RememberGameModel) {

    }

    func emphasizeCorrectWord(at indexPath: IndexPath) {

    }

    func emphasizeWrongWord(at indexPath: IndexPath) {

    }

    func showNextButton() {

    }

    func hideNextButton() {

    }
}
