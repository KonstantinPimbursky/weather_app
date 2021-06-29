//
//  HourlyData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 28.06.2021.
//
//

import Foundation
import CoreData


extension HourlyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyData> {
        return NSFetchRequest<HourlyData>(entityName: "HourlyData")
    }

    @NSManaged public var dt: Double
    @NSManaged public var temp: Double
    @NSManaged public var feelsLike: Double
    @NSManaged public var clouds: Int16
    @NSManaged public var windSpeed: Double
    @NSManaged public var windDeg: Int16
    @NSManaged public var pop: Int16
    @NSManaged public var forecast: ForecastData
    @NSManaged public var weather: NSSet

}

// MARK: Generated accessors for weather
extension HourlyData {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherData)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherData)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension HourlyData : Identifiable {

}
