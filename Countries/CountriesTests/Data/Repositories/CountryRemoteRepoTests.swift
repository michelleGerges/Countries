//
//  CountryRemoteRepoTests.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import XCTest
@testable import Countries

@MainActor
class CountryRemoteRepoDataRepositoriesTests: XCTestCase {
    private var client: NetworkClientMock!

    override func setUp() {
        super.setUp()
        client = NetworkClientMock()
        DIContainer.shared.register(NetworkClient.self) { self.client }
    }

    func testFetchCountryDelegatesToNetworkClient() async throws {
        let country = Country(
            name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
            currencies: ["EGP": Currency(name: "Egyptian pound")],
            capital: ["Cairo"]
        )
        let data = try JSONEncoder().encode(country)
        client.nextData = data

        let repo = CountryRemoteRepoImplementation()
        let result: Country = try await repo.fetchCountry(code: "EG")

        XCTAssertEqual(result.name.common, "Egypt")
        XCTAssertEqual(result.capital.first, "Cairo")
        XCTAssertEqual(result.currencies["EGP"]?.name, "Egyptian pound")
    }
}


