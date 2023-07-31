//
//  RuneUnitTests.swift
//  RunatalTests
//
//  Created by Andrey Skurlatov on 31.7.23..
//

import XCTest
@testable import Runatal

final class RuneUnitTests: XCTestCase {
    func testRuneMeaningGeneration() {
        let meaning = Meaning(English: ["cattle", "property", "wealth"], Russian: ["скот", "имущество", "богатство"])
        
        XCTAssertEqual(meaning.generate(language: .english), "cattle, property, wealth")
        XCTAssertEqual(meaning.generate(language: .russian), "скот, имущество, богатство")
    }
}
