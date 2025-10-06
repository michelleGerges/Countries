//
//  HomeView.swift
//  Countries
//
//  Created by michelle gergs on 04/10/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
            countriesList
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { ToolbarItem(placement: .primaryAction) { navigationSearchButton } }
        .task {
            await viewModel.loadCountries()
        }
        .isLoading(viewModel.countries.loading)
        .error(viewModel.$countries)
    }
    
    @ViewBuilder var navigationSearchButton: some View {
        Button {
            coordinator.navigateToSearch()
        } label: {
            Image(systemName: "magnifyingglass")
        }
    }
    
    @ViewBuilder var countriesList: some View {
        if let countries = viewModel.countries.data {
            List(countries) { country in
                CountryItemView(country: country)
            }
        }
    }
}
