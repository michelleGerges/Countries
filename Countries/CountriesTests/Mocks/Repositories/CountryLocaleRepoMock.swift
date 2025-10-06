//
//  CountryLocaleRepoMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 06/10/2025.
//

import Foundation
@testable import Countries

final class CountryLocaleRepoMock: CountryLocaleRepo {
    var nextCountries: [Country]? = nil
    var savedCountries: [Country] = []

    func saveCountry(_ country: Country) {
        savedCountries.append(country)
    }

    func getCountries() -> [Country]? {
        return nextCountries ?? savedCountries
    }

    func deleteCountry(_ country: Country) {
        savedCountries.removeAll { $0.id == country.id }
    }
}
