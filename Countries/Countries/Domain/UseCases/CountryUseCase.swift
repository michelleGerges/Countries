//
//  CountryUseCase.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

protocol CountryUseCase {
    func fetchCountries() async throws -> [Country]
    
    @discardableResult
    func addCountry(_ country: Country)  -> [Country]
    
    @discardableResult
    func removeCountry(_ country: Country) -> [Country]
}

class CountryUseCaseImplementation: CountryUseCase {
    
    @Dependency var locationProvider: LocationProvider
    @Dependency var remoteRepo: CountryRemoteRepo
    @Dependency var localeRepo: CountryLocaleRepo
    
    private func fetchUserCountry() async throws -> Country {
        let code = try await locationProvider.getUserCountryCode()
        return try await remoteRepo.fetchCountry(code: code)
    }
    
    func fetchCountries() async throws -> [Country] {
        if let countries = localeRepo.getCountries(), countries.isEmpty == false {
            return countries
        } else {
            let country = try await fetchUserCountry()
            localeRepo.saveCountry(country)
            return [country]
        }
    }
    
    func addCountry(_ country: Country) -> [Country] {
        if let countries = localeRepo.getCountries(), countries.count == Constants.MAX_COUNTRIES {
            localeRepo.deleteCountry(countries[0])
        }
        localeRepo.saveCountry(country)
        return localeRepo.getCountries() ?? []
    }
    
    func removeCountry(_ country: Country) -> [Country] {
        localeRepo.deleteCountry(country)
        return localeRepo.getCountries() ?? []
    }
}
