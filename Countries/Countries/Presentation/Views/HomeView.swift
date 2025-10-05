//
//  HomeView.swift
//  Countries
//
//  Created by michelle gergs on 04/10/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        VStack {
            countiresList
        }
        .task {
            await viewModel.loadCountries()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .isLoading(viewModel.countries.loading)
        .error(viewModel.$countries)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder var countiresList: some View {
        if let countries = viewModel.countries.data {
            List(countries) { country in
                CountryItemView(country: country)
            }
        }
    }
}
