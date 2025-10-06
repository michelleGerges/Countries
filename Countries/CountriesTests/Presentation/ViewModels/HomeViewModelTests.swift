//
//  HomeViewModelTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

@MainActor
final class HomeViewModelTests: XCTestCase {
    private var useCase: CountryUseCaseMock!

    override func setUp() {
        super.setUp()
        useCase = CountryUseCaseMock()
        DIContainer.shared.register(CountryUseCase.self) { self.useCase }
    }

    func testLoadCountriesSetsLoadingThenCompleted() async {
        useCase.delayNanoseconds = 2_000_000_000 // 2 seconds
        
        let sut = await MainActor.run { HomeViewModel() }

        XCTAssertFalse(sut.countries.loading)
        let task = Task { await sut.loadCountries() }
        await Task.yield()
        XCTAssertTrue(sut.countries.loading)
        await task.value
        XCTAssertTrue(sut.countries.completed)
        XCTAssertEqual(sut.countries.data?.first?.name.common, "Egypt")
    }

    func testLoadCountriesErrorSetsErrorState() async {
        useCase.delayNanoseconds = 2_000_000_000 // 2 seconds
        useCase.nextError = NetworkError.connectivity
        
        let sut = await MainActor.run { HomeViewModel() }
        let task = Task { await sut.loadCountries() }
        await Task.yield()
        XCTAssertTrue(sut.countries.loading)
        await task.value
        XCTAssertNotNil(sut.countries.error)
        XCTAssertFalse(sut.countries.completed)
    }

    func testHomeScreenTitleIsLocalized() async {
        let sut = await MainActor.run { HomeViewModel() }
        XCTAssertEqual(sut.title, NSLocalizedString("HOME_SCREEN_TITLE", comment: ""))
    }
    
    func testRemoveCountryUpdatesCountries() async {
        let countries = [
            Country(
                name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
                currencies: ["EGP": Currency(name: "Egyptian pound")],
                capital: ["Cairo"]
            ),
            Country(
                name: CountryName(common: "United States", official: "United States of America"),
                currencies: ["USD": Currency(name: "United States dollar")],
                capital: ["Washington, D.C."]
            )
        ]
        useCase.nextCountries = countries

        let sut = await MainActor.run { HomeViewModel() }
        sut.countries = .completed(countries)
        
        let countryToRemove = countries[0]
        sut.removeCountry(countryToRemove)
        
        XCTAssertTrue(sut.countries.completed)
        XCTAssertEqual(sut.countries.data?.count, 1)
        XCTAssertEqual(sut.countries.data?.first?.name.common, "United States")
    }
}


