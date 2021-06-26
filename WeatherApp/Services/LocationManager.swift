//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 20.06.2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static var shared = LocationManager()
    private let manager = CLLocationManager()
    private var completion: ((CLLocation)->Void)?
    
    private override init() {
        
    }
    
    public func startGetLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    public func getLocation() -> CLLocation? {
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        return manager.location
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
    }
}
