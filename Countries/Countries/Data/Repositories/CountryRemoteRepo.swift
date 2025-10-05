//
//  CountryLocaleRepo.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

protocol CountryRemoteRepo {
    func fetchCountry(code: String) async throws -> Country
}

class CountryRemoteRepoImplementation: CountryRemoteRepo {
    
    @Dependency var netowrkClient: NetworkClient
    
    func fetchCountry(code: String) async throws -> Country {
        try await netowrkClient.request(.country(code: code))
    }
}
