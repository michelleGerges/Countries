//
//  ConstantsTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

class ConstantsAppTests: XCTestCase {

    func test_network_constants_values() {
        XCTAssertEqual(Constants.Network.BASE_URL, "https://restcountries.com")
        XCTAssertEqual(Constants.Network.EndPoint.COUNTRY_BY_CODE, "/v3.1/alpha")
        XCTAssertEqual(Constants.Network.SUCCESS_RESPONSE_CODE, 200)
    }
}


