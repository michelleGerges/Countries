//
//  CountryItemView.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

import SwiftUI

struct CountryItemView: View {
    let country: Country
    let action: Action
    
    enum Action {
        case add((Country) -> Void)
        case added
        case remove((Country) -> Void)
        case none
    }
    
    var body: some View {
        HStack {
            Text(country.name.common)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            actionView
                .scaleEffect(2)
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder var actionView: some View {
        switch action {
        case .add(let addAction):
            Button {
                addAction(country)
            } label: {
                Image(systemName: "plus.circle.fill")
            }
            .buttonStyle(.borderless)
            
        case .added:
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            
        case .remove(let removeAction):
            Button {
                removeAction(country)
            } label: {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
            }
            .buttonStyle(.borderless)
            
        case .none:
            EmptyView()
        }
    }
}
