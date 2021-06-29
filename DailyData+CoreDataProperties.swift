//
//  DailyData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 28.06.2021.
//
//

import Foundation
import CoreData


extension DailyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyData> {
        return NSFetchRequest<DailyData>(entityName: "DailyData")
    }

    @NSManaged public var dt: Double
    @NSManaged public var sunrise: Double
    @NSManaged public var sunset: Double
    @NSManaged public var moonrise: Double
    @NSManaged public var moonset: Double
    @NSManaged public var moonPhase: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var windDeg: Int16
    @NSManaged public var clouds: Int16
    @NSManaged public var pop: Double
    @NSManaged public var uvi: Double
    @NSManaged public var forcast: ForecastData
    @NSManaged public var temp: TempData
    @NSManaged public var feelsLike: FeelsLikeData
    @NSManaged public var weather: NSSet

}

// MARK: Generated accessors for weather
extension DailyData {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherData)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherData)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension DailyData : Identifiable {

}
