//
//  CountriesApp.swift
//  Countries
//
//  Created by michelle gergs on 03/10/2025.
//

import SwiftUI
import SwiftData

@main
struct CountriesApp: App {

    init() {
        DIContainer.shared.registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
        }
    }
}
