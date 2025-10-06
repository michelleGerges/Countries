//
//  CountrySearchViewModel.swift
//  Countries
//
//  Created by michelle gergs on 06/10/2025.
//

import Foundation
import Combine

@MainActor
class CountrySearchViewModel: ObservableObject {
    
    @Published var searchState = ContentState<Void>.idle
    @Published var countries: [Country] = []
    @Published var searchKeyword: String = ""
    @Published var addedCountries = [Country]()
    
    @Dependency private var searchUseCase: CountrySearchUseCase
    @Dependency private var countriesUseCase: CountryUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        updateAddedCountries()
        $searchKeyword
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] (keyword: String) in
                
                if keyword.isEmpty {
                    self?.clearSearch()
                } else {
                    Task { await self?.performSearch(with: keyword) }
                }
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(with searchTerm: String) async {
        searchState = .loading
        do {
            let results = try await searchUseCase.fetchCountries(name: searchTerm)
            countries = results
            searchState = .completed(())
        } catch {
            searchState = .error(error)
        }
    }
    
    func clearSearch() {
        searchState = .idle
        countries.removeAll()
    }
    
    func isCountryAdded(_ country: Country) -> Bool {
        addedCountries.contains { $0.id == country.id }
    }
    
    func addCountry(_ country: Country) {
        addedCountries = countriesUseCase.addCountry(country)
    }
    
    func updateAddedCountries() {
        Task { addedCountries = try await countriesUseCase.fetchCountries() }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

extension CountrySearchViewModel {
    var title: String {
        NSLocalizedString("SEARCH_SCREEN_TITLE", comment: "")
    }
}
