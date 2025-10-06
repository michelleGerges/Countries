//
//  ConstantsTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

class ConstantsAppTests: XCTestCase {

    func testNetworkConstantsValues() {
        XCTAssertEqual(Constants.Network.BASE_URL, "https://restcountries.com")
        XCTAssertEqual(Constants.Network.EndPoint.COUNTRY_BY_CODE, "/v3.1/alpha")
        XCTAssertEqual(Constants.Network.EndPoint.SEARCH_COUNTRIES_BY_NAME, "/v3.1/name")
        XCTAssertEqual(Constants.Network.SUCCESS_RESPONSE_CODE, 200)
    }
    
    func testMaxCountriesConstant() {
        XCTAssertEqual(Constants.MAX_COUNTRIES, 5)
    }
}


