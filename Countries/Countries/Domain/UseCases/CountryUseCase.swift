//
//  CountryUseCase.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

protocol CountryUseCase {
    func fetchUserCountry() async throws -> Country
}

class CountryUseCaseImplementation: CountryUseCase {
    
    @Dependency var locationProvider: LocationProvider
    @Dependency var remoteRepo: CountryRemoteRepo
    
    func fetchUserCountry() async throws -> Country {
        let code = try await locationProvider.getUserCountryCode()
        return try await remoteRepo.fetchCountry(code: code)
    }
}
