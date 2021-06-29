//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 26.06.2021.
//

import Foundation

// MARK: - ForcastModel
struct ForecastModel: Codable {
    let lat: Double
    let lon: Double
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case current
        case hourly
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: Double
    let windSpeed: Int
    let weather: [Weather]
    let rain: Rain?
    let snow: Snow?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case windSpeed = "wind_speed"
        case weather, rain, snow
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let dt: Double
    let temp: Double
    let feelsLike: Double
    let clouds: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let pop: Int

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case clouds
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, pop
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Double
    let moonset: Double
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, pop, uvi
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night: Double
    
    enum CodingKeys: String, CodingKey {
        case day, night
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night
    }
}

// MARK: - Rain
struct Rain: Codable {
    let oneHour: String

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

// MARK: - Snow
struct Snow: Codable {
    let oneHour: String

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}
