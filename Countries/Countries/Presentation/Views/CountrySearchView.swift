//
//  CountrySearchView.swift
//  Countries
//
//  Created by michelle gergs on 06/10/2025.
//

import SwiftUI

struct CountrySearchView: View {
    @StateObject private var viewModel = CountrySearchViewModel()
    
    var body: some View {
        VStack {
            countriesList
            loading
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $viewModel.searchKeyword,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: searchPrompt)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .error(viewModel.$searchState)
    }
    
    @ViewBuilder var countriesList: some View {
        List(viewModel.countries) { country in
            CountryItemView(country: country,
                            action: viewModel.isCountryAdded(country) ? .added : .add(viewModel.addCountry))
        }
    }
    
    @ViewBuilder var loading: some View {
        if viewModel.searchState.loading {
            ProgressView()
                .scaleEffect(2.5)
        }
    }
}

extension CountrySearchView {
    var searchPrompt: String {
        NSLocalizedString("COUNTRIES_SEARCH_PROMPT", comment: "")
    }
}
