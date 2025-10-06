//
//  CountrySearchUseCase.swift
//  Countries
//
//  Created by michelle gergs on 06/10/2025.
//

protocol CountrySearchUseCase {
    func fetchCountries(name: String) async throws -> [Country]
}

class CountrySearchUseCaseImplementation: CountrySearchUseCase {
    
    @Dependency var remoteRepo: CountryRemoteRepo
    
    func fetchCountries(name: String) async throws -> [Country] {
        try await remoteRepo.fetchCountries(name: name)
    }
}
