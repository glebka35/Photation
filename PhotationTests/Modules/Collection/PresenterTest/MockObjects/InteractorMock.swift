//
//  InteractorMock.swift
//  PhotationTests
//
//  Created by Gleb Uvarkin on 02.09.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
@testable import Photation

class CollectionInteractorMock: CollectionInteractor {
    var viewDidLoadCount = 0
    var loadObjectsCount = 0

    override func viewDidLoad() {
        viewDidLoadCount += 1
        super.viewDidLoad()
    }

    override func loadObjects() {
        loadObjectsCount += 1
        super.loadObjects()
    }
}
