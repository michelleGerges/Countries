//
//  CountryUseCaseMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation
@testable import Countries

class CountryUseCaseMock: CountryUseCase {
    var nextCountry: Country = Country(
        name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
        currencies: ["EGP": Currency(name: "Egyptian pound")],
        capital: ["Cairo"]
    )
    var nextError: Error?
    var delayNanoseconds: UInt64? = nil

    func fetchUserCountry() async throws -> Country {
        if let delay = delayNanoseconds {
            try? await Task.sleep(nanoseconds: delay)
        }
        if let error = nextError { throw error }
        return nextCountry
    }
}



