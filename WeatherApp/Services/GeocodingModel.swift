//
//  GeocodingModel.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 24.06.2021.
//

import Foundation

struct GeocodingModel: Codable {
    
    let name: String
//    let localNames: [String : String]
    let lat: Double
    let lon: Double
    let country: String

    enum CodingKeys: String, CodingKey {
        case name
//        case localNames
        case lat
        case lon
        case country
    }
    
}
