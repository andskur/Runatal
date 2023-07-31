//
//  RunePoemUnitTests.swift
//  RunatalTests
//
//  Created by Andrey Skurlatov on 31.7.23..
//

import XCTest
@testable import Runatal

final class RunePoemUnitTests: XCTestCase {
    func testRunePoemTranslationGeneration() {
        let runePoemTranslations = RunePoemTranslations(English: "Wealth is a comfort to every man", Russian: "Богатство — утешение всем людям")
        
        XCTAssertEqual(runePoemTranslations.generate(language: .english), "Wealth is a comfort to every man")
        XCTAssertEqual(runePoemTranslations.generate(language: .russian), "Богатство — утешение всем людям")
    }
}
