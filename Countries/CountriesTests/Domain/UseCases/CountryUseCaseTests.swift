//
//  CountryUseCaseTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

@MainActor
final class CountryUseCaseDomainTests: XCTestCase {
    private var location: LocationProviderMock!
    private var remoteRepo: CountryRemoteRepoMock!
    private var localeRepo: CountryLocaleRepoMock!

    override func setUp() {
        super.setUp()
        location = LocationProviderMock()
        remoteRepo = CountryRemoteRepoMock()
        localeRepo = CountryLocaleRepoMock()
        DIContainer.shared.register(LocationProvider.self) { self.location }
        DIContainer.shared.register(CountryRemoteRepo.self) { self.remoteRepo }
        DIContainer.shared.register(CountryLocaleRepo.self) { self.localeRepo }
    }

    func testFetchCountriesReturnsLocalCountriesWhenAvailable() async throws {
        let countries = [
            Country(
                name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
                currencies: ["EGP": Currency(name: "Egyptian pound")],
                capital: ["Cairo"]
            )
        ]
        localeRepo.nextCountries = countries

        let sut = CountryUseCaseImplementation()
        let result = try await sut.fetchCountries()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name.common, "Egypt")
    }
}
