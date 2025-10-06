//
//  EndPointTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

class EndPointDataNetworkTests: XCTestCase {

    func testCountryFullUrlForCodeEg() throws {
        let sut = EndPoint.country(code: "EG")
        let url = sut.fullURL

        XCTAssertEqual(url?.absoluteString, "https://restcountries.com/v3.1/alpha/EG?fields=name,capital,currencies")
    }
    
    func testSearchCountriesFullUrlForKeyword() throws {
        let sut = EndPoint.searchCountries(keyword: "Egypt")
        let url = sut.fullURL

        XCTAssertEqual(url?.absoluteString, "https://restcountries.com/v3.1/name/Egypt?fields=name,capital,currencies")
    }
}


