//
//  RunatalTests.swift
//  RunatalTests
//
//  Created by Andrey Skurlatov on 31.7.23..
//

import XCTest
@testable import Runatal

final class RunesControllerlTests: XCTestCase {
    var runesController: RunesController!
    
    override func setUp() {
        super.setUp()
        runesController = RunesController()
    }

    override func tearDown() {
        runesController = nil
        super.tearDown()
    }

    func testLoadRunesData() {
        runesController.loadRunesData()
        XCTAssertFalse(runesController.loadedRunes.isEmpty)
    }
}
