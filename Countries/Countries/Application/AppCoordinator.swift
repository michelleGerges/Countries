//
//  AppCoordinator.swift
//  Countries
//
//  Created by michelle gergs on 03/10/2025.
//

import Foundation
import SwiftUI
import Combine

enum Route {
    case search
}

class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func navigateToSearch() {
        navigationPath.append(Route.search)
    }
    
    func navigateToCountryDetials(_ country: Country) {
        navigationPath.append(country)
    }
}

struct AppCoordinatorView: View {
    
    @StateObject var appCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.navigationPath) {
            HomeView()
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .search: CountrySearchView()
                    }
                })
                .navigationDestination(for: Country.self, destination: { country in
                    CountryDetailsView(country: country)
                })
                .environmentObject(appCoordinator)
        }
    }
}
