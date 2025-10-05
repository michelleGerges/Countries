//
//  LocationService.swift
//  Countries
//
//  Created by michelle gergs on 04/10/2025.
//

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()
    
    private lazy var manager: CLLocationManager = {
       CLLocationManager()
    }()
    
    private var completion: ((CLLocation?) -> Void)?
    
    func getCurrentLocation(_ completion: @escaping (CLLocation?) -> Void) {
        
        self.completion = completion
        manager.delegate = self
        
        checkStatus()
    }
    
    private func checkStatus() {
        let status = manager.authorizationStatus
        
        switch status {
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
            
        case .denied, .restricted:
            completion?(nil)
            completion = nil
            
        @unknown default:
            completion?(nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            completion?(location)
            completion = nil
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError:", error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkStatus()
    }
}
