//
//  Country.swift
//  Countries
//
//  Created by michelle gergs on 05/10/2025.
//

struct Country: Codable, Identifiable, Hashable {
    let name: CountryName
    let currencies: [String: Currency]
    let capital: [String]
    
    var id: String { name.common }
}

struct CountryName: Codable, Hashable {
    let common: String
    let official: String
}

struct Currency: Codable, Hashable {
    let name: String
}
