//
//  CountryRemoteRepoMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation
@testable import Countries

final class CountryRemoteRepoMock: CountryRemoteRepo {
    var nextCountry: Country = Country(
        name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
        currencies: ["EGP": Currency(name: "Egyptian pound")],
        capital: ["Cairo"]
    )
    var nextCountries: [Country] = []
    var nextError: Error?

    func fetchCountry(code: String) async throws -> Country {
        if let error = nextError { throw error }
        return nextCountry
    }
    
    func fetchCountries(name: String) async throws -> [Country] {
        if let error = nextError { throw error }
        return nextCountries
    }
}
