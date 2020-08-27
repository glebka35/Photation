//
//  TableViewCell+.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

extension SettingsTableViewCell {
    func update(with language: LanguageCellViewModel, isFirst: Bool, isLast: Bool) {

        textLabel?.text = language.main
        detailTextLabel?.text = language.additional

        topSeparator.isHidden = !isFirst
        bottomSeparator.isHidden = !isLast

        accessoryType = language.isChosen ? .checkmark : .none
    }
}
