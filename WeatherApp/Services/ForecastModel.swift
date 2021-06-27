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
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Int
    let windGust: String?
    let windDeg: Int
    let weather: [Weather]
    let rain: Rain?
    let snow: Snow?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
        case weather, rain, snow
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [Weather]
    let pop: Int
    let rain: Rain?
    let snow: Snow?

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop, rain, snow
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windGust: Double?
    let windDeg: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let snow: Double?
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
        case weather, clouds, pop, rain, snow, uvi
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
    
    enum CodingKeys: String, CodingKey {
        case day, night, eve, morn
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night
        case eve, morn
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
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
