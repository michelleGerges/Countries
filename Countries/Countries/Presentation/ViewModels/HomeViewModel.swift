//
//  HomeViewModel.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var countries = ContentState<[Country]>.idle
    
    @Dependency private var countryUseCase: CountryUseCase
    
    func loadCountries() async {
        countries = .loading
        do {
            let countriesData = try await countryUseCase.fetchCountries()
            countries = .completed(countriesData)
        } catch {
            countries = .error(error)
        }
    }
    
    func removeCountry(_ country: Country) {
        let updatedCountries = countryUseCase.removeCountry(country)
        countries = .completed(updatedCountries)
    }
}

extension HomeViewModel {
    var title: String {
        NSLocalizedString("HOME_SCREEN_TITLE", comment: "")
    }
}
