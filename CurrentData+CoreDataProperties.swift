//
//  CurrentData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 28.06.2021.
//
//

import Foundation
import CoreData


extension CurrentData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentData> {
        return NSFetchRequest<CurrentData>(entityName: "CurrentData")
    }

    @NSManaged public var dt: Double
    @NSManaged public var sunrise: Double
    @NSManaged public var sunset: Double
    @NSManaged public var temp: Double
    @NSManaged public var windSpeed: Int16
    @NSManaged public var forcast: ForecastData
    @NSManaged public var rain: RainData?
    @NSManaged public var snow: SnowData?
    @NSManaged public var weather: NSSet

}

// MARK: Generated accessors for weather
extension CurrentData {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherData)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherData)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension CurrentData : Identifiable {

}
