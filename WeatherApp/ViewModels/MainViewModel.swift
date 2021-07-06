//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 25.06.2021.
//

import Foundation

// MARK: -
protocol MainOutput {
    func getForecast(completion: @escaping (ForecastData) -> Void)
    func getLocation(compeletion: @escaping (_ location: String) -> Void)
}

// MARK: -
class MainViewModel: MainOutput {

    private var latitude: Double = 0
    private var longitude: Double = 0
    private let coreDataStack: CoreDataStack
    private let networkService: NetworkProtocol
    
    init(coreDataStack: CoreDataStack,
         networkService: NetworkProtocol) {
        self.coreDataStack = coreDataStack
        self.networkService = networkService
    }
    
    func getForecast(completion: @escaping (ForecastData) -> Void) {
        if LocationManager.shared.isEnabled(),
           let location = LocationManager.shared.getLocation() {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
        var weatherForecast = coreDataStack.fetchForecastData()
        if weatherForecast.isEmpty {
            DispatchQueue.global(qos: .background).async {
                self.networkService.getForecastFromNetwork(latitude: self.latitude, longitude: self.longitude) { forecast in
                    self.coreDataStack.createNewForecastData(forecast: forecast) {
                        weatherForecast = self.coreDataStack.fetchForecastData()
                        DispatchQueue.main.async {
                            completion(weatherForecast[0])
                        }
                        
                    }
                }
            }
        } else {
            DispatchQueue.global(qos: .background).async {
                self.coreDataStack.remove(forecastData: weatherForecast[0])
                self.networkService.getForecastFromNetwork(latitude: self.latitude, longitude: self.longitude) { forecast in
                    self.coreDataStack.createNewForecastData(forecast: forecast) {
                        return
                    }
                }
                DispatchQueue.main.async {
                    completion(weatherForecast[0])
                }
            }
        }
    }
    
    func getLocation(compeletion: @escaping (String) -> Void) {
        if LocationManager.shared.isEnabled(),
           let location = LocationManager.shared.getLocation() {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
        networkService.getCityFromCoordinates(latitude: latitude, longitude: longitude) { location in
            compeletion(location)
        }
    }
}
    
