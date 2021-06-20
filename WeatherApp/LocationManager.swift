//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 20.06.2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private var completion: ((CLLocation)->Void)?
    
    public func startGetLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    public func getLocation(completion: @escaping ((CLLocation)->Void)) {
        if CLLocationManager.locationServicesEnabled() {
            self.completion = completion
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
    }
}
