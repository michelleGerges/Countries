//
//  LocationProviderMock.swift
//  CountriesTests
//
//  Created by michelle gergs on 05/10/2025.
//

import Foundation
@testable import Countries

class LocationProviderMock: LocationProvider {
    var nextCode: String = "EG"
    var nextError: Error?

    func getUserCountryCode() async throws -> String {
        if let error = nextError { throw error }
        return nextCode
    }
}
