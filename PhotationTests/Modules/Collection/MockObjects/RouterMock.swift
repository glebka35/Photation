//
//  CollectionRouterMock.swift
//  PhotationTests
//
//  Created by Gleb Uvarkin on 02.09.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
@testable import Photation

class CollectionRouterMock: CollectionRouter {
    var showDetailCount = 0
    var closeModuleCount = 0

    override func showDetail(of object: ObjectsOnImage) {
        showDetailCount += 1
        super.showDetail(of: object)
    }

    override func closeModule() {
        closeModuleCount += 1
        super.closeModule()
    }
}
