//
//  CountryUseCaseTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

@MainActor
class CountryUseCaseDomainTests: XCTestCase {
    private var location: LocationProviderMock!
    private var repo: CountryRemoteRepoMock!

    override func setUp() {
        super.setUp()
        location = LocationProviderMock()
        repo = CountryRemoteRepoMock()
        DIContainer.shared.register(LocationProvider.self) { self.location }
        DIContainer.shared.register(CountryRemoteRepo.self) { self.repo}
    }

    func testFetchUserCountryUsesLocationProviderAndRepo() async throws {

        location.nextCode = "EG"
        repo.nextCountry = Country(
            name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
            currencies: ["EGP": Currency(name: "Egyptian pound")],
            capital: ["Cairo"]
        )

        let sut = CountryUseCaseImplementation()
        let result = try await sut.fetchUserCountry()

        XCTAssertEqual(result.name.common, "Egypt")
    }
}


