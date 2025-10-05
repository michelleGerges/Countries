//
//  CountryItemView.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

import SwiftUI

struct CountryItemView: View {
    let country: Country
    
    var body: some View {
        HStack {
            Text(country.name.common)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
