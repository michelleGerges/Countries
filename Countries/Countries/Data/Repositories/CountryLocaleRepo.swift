//
//  CountryLocaleRepo.swift
//  Countries
//
//  Created by michelle gergs on 06/10/2025.
//

import Foundation
import SwiftData


protocol ModelContextProtocol {
    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T]
    func insert<T: PersistentModel>(_ model: T)
    func save() throws
    func delete<T: PersistentModel>(_ model: T)
}

// ModelContext Wrapper
class ModelContextWrapper: ModelContextProtocol {
    private let modelContext: ModelContext
    
    init?() {
        guard let modelContainer = try? ModelContainer(for: CountryEntity.self) else {
            return nil
        }
        self.modelContext = ModelContext(modelContainer)
    }
    
    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        try modelContext.fetch(descriptor)
    }
    
    func insert<T: PersistentModel>(_ model: T) {
        modelContext.insert(model)
    }
    
    func save() throws {
        try modelContext.save()
    }
    
    func delete<T: PersistentModel>(_ model: T) {
        modelContext.delete(model)
    }
}

// SwiftData Model
@Model
class CountryEntity {
    @Attribute(.unique) var commonName: String
    var officialName: String
    var capital: [String]
    var currencyKeys: [String]
    var currencyValues: [String]
    var createdAtDate: Date
    
    init(from country: Country) {
        self.commonName = country.name.common
        self.officialName = country.name.official
        self.capital = country.capital
        self.currencyKeys = Array(country.currencies.keys)
        self.currencyValues = country.currencies.map { $0.value.name }
        self.createdAtDate = Date()
    }
    
    func toCountry() -> Country {
        var currencies: [String: Currency] = [:]
        for (index, key) in currencyKeys.enumerated() {
            if index < currencyValues.count {
                currencies[key] = Currency(name: currencyValues[index])
            }
        }
        
        return Country(
            name: CountryName(common: commonName, official: officialName),
            currencies: currencies,
            capital: capital
        )
    }
}

protocol CountryLocaleRepo {
    func saveCountry(_ country: Country)
    func getCountries() -> [Country]?
    func deleteCountry(_ country: Country)
}

class CountryLocaleRepoImplementation: CountryLocaleRepo {
    
    @Dependency private var modelContext: ModelContextProtocol
    
    func saveCountry(_ country: Country) {
        
        let descriptor = FetchDescriptor<CountryEntity>(
            predicate: #Predicate<CountryEntity> { $0.commonName == country.name.common }
        )
        guard let existing = try? modelContext.fetch(descriptor) else {
            return
        }
        
        if let existingEntity = existing.first {
            existingEntity.commonName = country.name.common
            existingEntity.officialName = country.name.official
            existingEntity.capital = country.capital
            existingEntity.currencyKeys = Array(country.currencies.keys)
            existingEntity.currencyValues = country.currencies.map { $0.value.name }
        } else {
            let countryEntity = CountryEntity(from: country)
            modelContext.insert(countryEntity)
        }
        
        try? modelContext.save()
    }
    
    func getCountries() -> [Country]? {        
        let descriptor = FetchDescriptor<CountryEntity>(
            sortBy: [SortDescriptor(\.createdAtDate)]
        )
        let entities = try? modelContext.fetch(descriptor)
        return entities?.map { $0.toCountry() }
    }
    
    func deleteCountry(_ country: Country) {
        let descriptor = FetchDescriptor<CountryEntity>(
            predicate: #Predicate<CountryEntity> { $0.commonName == country.name.common }
        )
        guard let entities = try? modelContext.fetch(descriptor) else {
            return
        }
        
        for entity in entities {
            modelContext.delete(entity)
        }
        
        try? modelContext.save()
    }
}
