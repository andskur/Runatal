//
//  TranslationUnitTests.swift
//  RunatalTests
//
//  Created by Andrey Skurlatov on 8.8.23..
//

import XCTest
@testable import Runatal

final class TranslationUnitTests: XCTestCase {
    func testMeaningTranslationGenerations() {
        let meaning = MeaningTranslation.init(english: ["cattle", "property", "wealth"], russian: ["скот", "имущество", "богатство"])
        
        XCTAssertEqual(meaning.generate(language: .english), "cattle, property, wealth")
        XCTAssertEqual(meaning.generate(language: .russian), "скот, имущество, богатство")
    }
    
    func testTranslationGenerations() {
        let meaning = Translation.init(english: "Wealth is cause of strife among kin; the wolf is born in the forest.", russian: "Богатство вызывает раздор родичей; волк кормится в лесу.")
        
        XCTAssertEqual(meaning.generate(language: .english), "Wealth is cause of strife among kin; the wolf is born in the forest.")
        XCTAssertEqual(meaning.generate(language: .russian), "Богатство вызывает раздор родичей; волк кормится в лесу.")
    }
}
