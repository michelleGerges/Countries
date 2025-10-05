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
    
}

class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
}

struct AppCoordinatorView: View {
    
    @StateObject var appCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.navigationPath) {
            Group {
                HomeView()
            }
            .environmentObject(appCoordinator)
        }
    }
}
