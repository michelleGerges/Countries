//
//  CountryUseCaseMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation
@testable import Countries

final class CountryUseCaseMock: CountryUseCase {
    var nextCountry: Country = Country(
        name: CountryName(common: "Egypt", official: "Arab Republic of Egypt"),
        currencies: ["EGP": Currency(name: "Egyptian pound")],
        capital: ["Cairo"]
    )
    var nextCountries: [Country] = []
    var nextError: Error?
    var delayNanoseconds: UInt64? = nil

    func fetchCountries() async throws -> [Country] {
        if let delay = delayNanoseconds {
            try? await Task.sleep(nanoseconds: delay)
        }
        if let error = nextError { throw error }
        return nextCountries.isEmpty ? [nextCountry] : nextCountries
    }
    
    func addCountry(_ country: Country) -> [Country] {
        var countries = nextCountries.isEmpty ? [nextCountry] : nextCountries
        countries.append(country)
        nextCountries = countries
        return countries
    }
    
    func removeCountry(_ country: Country) -> [Country] {
        var countries = nextCountries.isEmpty ? [nextCountry] : nextCountries
        countries.removeAll { $0.id == country.id }
        nextCountries = countries
        return countries
    }
}




