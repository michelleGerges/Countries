//
//  CountrySearchUseCaseTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 06/10/2025.
//

import XCTest
@testable import Countries

@MainActor
final class CountrySearchUseCaseDomainTests: XCTestCase {
    private var repo: CountryRemoteRepoMock!

    override func setUp() {
        super.setUp()
        repo = CountryRemoteRepoMock()
        DIContainer.shared.register(CountryRemoteRepo.self) { self.repo }
    }

    func testFetchCountriesDelegatesToRepo() async throws {
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
        repo.nextCountries = countries

        let sut = CountrySearchUseCaseImplementation()
        let result = try await sut.fetchCountries(name: "Egypt")

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name.common, "Egypt")
        XCTAssertEqual(result.last?.name.common, "United States")
    }
}
