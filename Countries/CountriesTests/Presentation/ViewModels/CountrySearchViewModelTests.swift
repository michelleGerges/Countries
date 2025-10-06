//
//  CountrySearchViewModelTests.swift
//  CountriesTests
//
//  Created by Tests.
//

import XCTest
@testable import Countries

@MainActor
final class CountrySearchViewModelTests: XCTestCase {
    private var searchUseCase: CountrySearchUseCaseMock!

    override func setUp() {
        super.setUp()
        searchUseCase = CountrySearchUseCaseMock()
        DIContainer.shared.register(CountrySearchUseCase.self) { self.searchUseCase }
    }

    func testSearchKeywordAndFetches() async {
        let sut = CountrySearchViewModel()
        let countries = [
            Country(
                name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
                currencies: ["EGP": Currency(name: "Egyptian pound")],
                capital: ["Cairo"]
            )
        ]
        searchUseCase.nextCountries = countries
        
        sut.searchKeyword = "Egypt"
        
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        XCTAssertEqual(sut.countries.count, 1)
        XCTAssertEqual(sut.countries.first?.name.common, "Egypt")
        XCTAssertTrue(sut.searchState.completed)
    }
    
    func testClearSearchResetsState() {
        let sut = CountrySearchViewModel()
        sut.countries = [Country(
            name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
            currencies: ["EGP": Currency(name: "Egyptian pound")],
            capital: ["Cairo"]
        )]
        sut.searchState = .completed(())
        
        sut.clearSearch()
        
        XCTAssertTrue(sut.countries.isEmpty)
        XCTAssertEqual(sut.searchKeyword, "")
    }
    
    func testSearchTitleIsLocalized() {
        let sut = CountrySearchViewModel()
        XCTAssertEqual(sut.title, "Search")
    }
    
}
