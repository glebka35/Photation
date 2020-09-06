//
//  ViewMok.swift
//  PhotationTests
//
//  Created by Gleb Uvarkin on 02.09.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
@testable import Photation

class CollectionViewMock: CollectionView {
    var viewDidLoadCount = 0
    var updateContentCount = 0
    var clearSearchBarCount = 0
    var cellSelectedCount = 0

    override func viewDidLoad() {
        viewDidLoadCount += 1
        super.viewDidLoad()
    }

    override func updateContent(with model: CollectionViewModel) {
        updateContentCount += 1
        super.updateContent(with: model)
    }

    override func clearSearchBar() {
        clearSearchBarCount += 1
        super.clearSearchBar()
    }

    func publicCellSelected(at indexPath: IndexPath) {
        cellSelectedCount += 1
        super.cellSelected(at: indexPath)
    }
}
