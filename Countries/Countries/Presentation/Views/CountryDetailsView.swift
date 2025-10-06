//
//  CountryDetailsView.swift
//  Countries
//
//  Created by michelle gergs on 06/10/2025.
//

import SwiftUI

struct CountryDetailsView: View {
    let country: Country
    
    var body: some View {
        List {
            HStack {
                Text(NSLocalizedString("COUNTRY_DETAILS_CAPITAL_TITLE", comment: ""))
                Spacer()
                Text(country.capital.first ?? "-")
                    .foregroundColor(.secondary)
            }
            HStack {
                Text(NSLocalizedString("COUNTRY_DETAILS_CURRENCY_TITLE", comment: ""))
                Spacer()
                Text(primaryCurrencyName)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(country.name.common)
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var primaryCurrencyName: String {
        if let first = country.currencies.first?.value.name { return first }
        return "-"
    }
}


