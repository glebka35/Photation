//
//  CollectionPresenterTests.swift
//  PhotationTests
//
//  Created by Gleb Uvarkin on 02.09.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import XCTest

class CollectionPresenterTests: XCTestCase {
    var view: CollectionViewMock!

    override func setUpWithError() throws {
        view = CollectionAssemblyMock().createCollectionModule()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

        let _ = view.view
        XCTAssert(view.viewDidLoadCount == 1, "View loading problem!")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
