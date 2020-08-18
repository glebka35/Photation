//
//  CollectionViewActionsDelegate.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

//MARK: - CollectionView actions delegate

protocol CollectionViewActionsDelegate: AnyObject {
    func cellSelected(at indexPath: IndexPath)
    func scrollViewDidScrollToBottom()
}

extension CollectionViewActionsDelegate {
    func scrollViewDidScrollToBottom() {}
}
