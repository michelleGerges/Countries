//
//  Extension.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

import SwiftUI
import Combine

extension View {
    func isLoading(_ loading: Bool) -> some View {
        self.modifier(LoadingModifier(isLoading: loading))
    }
}

struct LoadingModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isLoading)
            .blur(radius: isLoading ? 2 : 0)
            .overlay {
                if isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .scaleEffect(2.5)
                        .tint(.white)
                }
            }
            .animation(.easeInOut, value: isLoading)
    }
}
