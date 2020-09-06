//
//  PresenterMock.swift
//  PhotationTests
//
//  Created by Gleb Uvarkin on 06.09.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
@testable import Photation

class CollectionPresenterMock: CollectionPresenter {
    var viewDidLoadCount = 0
    var changePresentationCount = 0
    var cellSelectedCount = 0
    var scrollViewDidScrollToBottomCount = 0
    var updateDataCount = 0
    var objectsDidFetchCount = 0

    override func viewDidLoad(with style: PresentationStyle) {
        viewDidLoadCount += 1
        super.viewDidLoad(with: style)
    }

    override func changePresentation() {
        changePresentationCount += 1
        super.changePresentation()
    }

    override func cellSelected(at indexPath: IndexPath) {
        cellSelectedCount += 1
        super.cellSelected(at: indexPath)
    }

    override func scrollViewDidScrollToBottom() {
        scrollViewDidScrollToBottomCount += 1
        super.scrollViewDidScrollToBottom()
    }
}
