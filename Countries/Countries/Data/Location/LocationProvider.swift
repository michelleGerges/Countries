//
//  LocationProvider.swift
//  Countries
//
//  Created by michelle gergs on 04/10/2025.
//

import Foundation
import CoreLocation

protocol LocationProvider {
    func getUserCountryCode() async throws -> String
}

enum LocationError: Error {
    case locationNotFound
}

class LocationProviderImplementation: LocationProvider {
    
    private lazy var geocoder: CLGeocoder = {
        CLGeocoder()
    }()
    
    private lazy var locationService: LocationService = {
        LocationService()
    }()
    
    func getUserCountryCode() async throws -> String {
        if let location = await getDeviceLocation(),
           let countryCode = await getCountry(from: location) {
            return countryCode
        } else if let region = Locale.current.region {
            return region.identifier
        } else {
            throw LocationError.locationNotFound
        }
    }
    
    private func getDeviceLocation() async -> CLLocation? {
        await withCheckedContinuation { continuation in
            self.locationService.getCurrentLocation { location in
                continuation.resume(returning: location)
            }
        }
    }
    
    func getCountry(from location: CLLocation) async -> String? {
        let placemarks = try? await geocoder.reverseGeocodeLocation(location)
        return placemarks?.first?.isoCountryCode
    }
}
