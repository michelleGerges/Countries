//
//  DIContainer.swift
//  Countries
//
//  Created by michelle gergs on 03/10/2025.
//

import Foundation

@propertyWrapper
struct Dependency<T> {
    
    var dependency: T
    
    init() {
        guard let resolved = DIContainer.shared.resolve(T.self) else {
            fatalError("No Dependency Resolved for \(T.self)")
        }
        dependency = resolved
    }
    
    var wrappedValue: T {
        get { dependency }
        set { dependency = newValue }
    }
}

class DIContainer {
    
    static let shared = DIContainer()
    private var factories: [String: () -> Any] = [:]
    
    func register<T>(_ dependency: T.Type, _ factory: @escaping () -> T) {
        factories[String(describing: T.self)] = factory
    }
    
    func resolve<T>(_ dependency: T.Type) -> T? {
        factories[String(describing: T.self)]?() as? T
    }
    
    func registerDependencies() {
        register(URLSessionProtocol.self) { URLSession.shared }
        register(NetworkClient.self) { NetworkClientImplementation() }
        register(CountryRemoteRepo.self) { CountryRemoteRepoImplementation() }
        register(LocationProvider.self) { LocationProviderImplementation() }
        register(CountryUseCase.self) { CountryUseCaseImplementation() }
        register(CountrySearchUseCase.self) { CountrySearchUseCaseImplementation() }
    }
}
