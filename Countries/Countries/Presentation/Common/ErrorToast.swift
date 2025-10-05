//
//  ErrorToast.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//


import SwiftUI
import Combine

extension View {
    func error<T>(_ publisher: Published<T>.Publisher) -> some View where T: ErrorState {
        self.modifier(ErrorToastPublisherModifier(publisher: publisher))
    }
}

protocol ErrorState {
    var error: Error? { get }
}

extension ContentState: ErrorState { }

struct ErrorToastPublisherModifier<T: ErrorState>: ViewModifier {
    let publisher: Published<T>.Publisher
    @State private var showToast = false
    @State private var errorMessage = ""
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if showToast {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text(errorMessage)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    
                }
            }
            .onReceive(publisher) { state in
                if let error = state.error {
                    if showToast { return }
                    withAnimation {
                        errorMessage = error.message
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation { showToast = false }
                        }
                    }
                }
            }
    }
}
