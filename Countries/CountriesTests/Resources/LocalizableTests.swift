//
//  LocalizableTests.swift
//  CountriesTests
//
//  Created by Tests.
//

import XCTest
@testable import Countries

final class LocalizableTests: XCTestCase {

    func testEnglishHomeScreenTitleExistsAndMatches() {
        let value = NSLocalizedString("HOME_SCREEN_TITLE", comment: "")
        XCTAssertEqual(value, "Home")
    }
    
    func testEnglishSearchScreenTitleExistsAndMatches() {
        let value = NSLocalizedString("SEARCH_SCREEN_TITLE", comment: "")
        XCTAssertEqual(value, "Search")
    }
    
    func testEnglishSearchPromptExistsAndMatches() {
        let value = NSLocalizedString("COUNTRIES_SEARCH_PROMPT", comment: "")
        XCTAssertEqual(value, "Search countries")
    }
    
    func testEnglishCountryDetailsLabelsExistAndMatch() {
        XCTAssertEqual(NSLocalizedString("COUNTRY_DETAILS_CAPITAL_TITLE", comment: ""), "Capital")
        XCTAssertEqual(NSLocalizedString("COUNTRY_DETAILS_CURRENCY_TITLE", comment: ""), "Currency")
    }
}



