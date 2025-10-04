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
        guard let resolved = DIContainer.resolve(T.self) else {
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
    
    private static var factories: [String: () -> Any] = [:]
    
    static func register<T>(_ dependency: T.Type, _ factory: @autoclosure @escaping () -> T) {
        factories[String(describing: T.self)] = factory
    }
    
    static func resolve<T>(_ dependency: T.Type) -> T? {
        factories[String(describing: dependency.self)]?() as? T
    }
    
    static func registerDependencies() {
        register(URLSession.self, URLSession.shared)
    }
}
