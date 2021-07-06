//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 04.07.2021.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func getForecastFromNetwork(latitude: Double, longitude: Double, completion: @escaping (ForecastModel) -> Void)
    func getCityFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (_ location: String) -> Void)
    func getCoordinatesFromCity(city: String, completion: @escaping (_ latitude: Double, _ longitude: Double) -> Void)
}

class NetworkService: NetworkProtocol {
    private let apiKey = "107e2da708b5767f8a8c4c925485a06c"
    
    func getForecastFromNetwork(latitude: Double, longitude: Double, completion: @escaping (ForecastModel) -> Void) {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.openweathermap.org"
            components.path = "/data/2.5/onecall"
            components.queryItems = [
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "exclude", value: "minutely,alerts"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "ru"),
                URLQueryItem(name: "appid", value: self.apiKey)
            ]
            AF.request(components).validate().responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    do {
                        let data = responseJSON.data!
                        let forecast = try JSONDecoder().decode(ForecastModel.self, from: data)
                        completion(forecast)
                    } catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getCityFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (_ location: String) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var components = URLComponents()
            components.scheme = "http"
            components.host = "api.openweathermap.org"
            components.path = "/geo/1.0/reverse"
            components.queryItems = [
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "appid", value: self.apiKey)
            ]
            AF.request(components).validate().responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    do {
                        let data = responseJSON.data
                        let locality = try JSONDecoder().decode([GeocodingModel].self, from: data!)
                        let location = "\(locality[0].name).\(locality[0].country)"
                        DispatchQueue.main.async {
                            completion(location)
                        }
                    } catch {
                        print("Не удалось декодировать локацию")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getCoordinatesFromCity(city: String, completion: @escaping (_ latitude: Double, _ longitude: Double) -> Void) {
        return
    }
}
