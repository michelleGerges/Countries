//
//  LocalizableTests.swift
//  CountriesTests
//
//  Created by Tests.
//

import XCTest
@testable import Countries

class LocalizableTests: XCTestCase {

    func testEnglishHomeScreenTitleExistsAndMatches() {
        let value = NSLocalizedString("HOME_SCREEN_TITLE", comment: "")
        XCTAssertEqual(value, "Home")
    }
}



