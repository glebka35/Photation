//
//  CollectionPresenterTests.swift
//  PhotationTests
//
//  Created by Gleb Uvarkin on 02.09.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import XCTest
@testable import Photation

class CollectionPresenterTests: XCTestCase {
    var view: CollectionViewMock!
    var presenter: CollectionPresenter!
    var interactor: CollectionInteractorMock!
    var router: CollectionRouterMock!

    override func setUpWithError() throws {
        view = CollectionViewMock()
        presenter = CollectionPresenter()
        interactor = CollectionInteractorMock()
        router = CollectionRouterMock()

        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoading() throws {
        let _ = view.view
        XCTAssert(view.viewDidLoadCount == 1, "View loading problem!")
        XCTAssert(interactor.viewDidLoadCount == 1, "Interactor detect view load")
        XCTAssert(interactor.loadObjectsCount == 1, "Load objects didn't occur")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
