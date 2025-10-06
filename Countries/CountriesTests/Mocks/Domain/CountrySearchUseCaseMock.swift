//
//  CountrySearchUseCaseMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 06/10/2025.
//

import Foundation
@testable import Countries

@MainActor
final class CountrySearchUseCaseMock: CountrySearchUseCase {
    var nextCountries: [Country] = [
        Country(
            name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
            currencies: ["EGP": Currency(name: "Egyptian pound")],
            capital: ["Cairo"]
        )
    ]
    var nextError: Error?

    func fetchCountries(name: String) async throws -> [Country] {
        if let error = nextError { throw error }
        return nextCountries
    }
}
