//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 25.06.2021.
//

import Foundation
import Alamofire

// MARK: -
protocol MainOutput {
    func getCityFromCoordinates(completion: @escaping (_ city: String) -> Void)
}

// MARK: -
class MainViewModel: MainOutput {
    
    private let apiKey = "107e2da708b5767f8a8c4c925485a06c"
    private var latitude: Double = 0
    private var longitude: Double = 0
    
    init() {
        if let location = LocationManager.shared.getLocation() {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
        
    }
    
    func getCityFromCoordinates(completion: @escaping (_ city: String) -> Void) {
        DispatchQueue.global(qos: .background).sync {
            var components = URLComponents()
            components.scheme = "http"
            components.host = "api.openweathermap.org"
            components.path = "/geo/1.0/reverse"
            components.queryItems = [
                URLQueryItem(name: "lat", value: String(self.latitude)),
                URLQueryItem(name: "lon", value: String(self.longitude)),
                URLQueryItem(name: "appid", value: self.apiKey)
            ]
            AF.request(components).validate().responseJSON { responseJSON in
                switch responseJSON.result {
                case .success (let value):
                    print(value)
                    do {
                        let data = responseJSON.data
                        let locality = try JSONDecoder().decode([GeocodingModel].self, from: data!)
                        let city = "\(locality[0].name).\(locality[0].country)"
                        completion(city)
                    } catch {
                        print("Не удалось декодировать JSON")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
    
