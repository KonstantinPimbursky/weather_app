//
//  DailyData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 27.07.2021.
//
//

import Foundation
import CoreData


extension DailyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyData> {
        return NSFetchRequest<DailyData>(entityName: "DailyData")
    }

    @NSManaged public var clouds: Int16
    @NSManaged public var dt: Double
    @NSManaged public var moonPhase: Double
    @NSManaged public var moonrise: Double
    @NSManaged public var moonset: Double
    @NSManaged public var pop: Double
    @NSManaged public var sunrise: Double
    @NSManaged public var sunset: Double
    @NSManaged public var uvi: Double
    @NSManaged public var windDeg: Int16
    @NSManaged public var windSpeed: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var rain: Int16
    @NSManaged public var snow: Int16
    @NSManaged public var forecast: ForecastData
    @NSManaged public var weather: WeatherData
    @NSManaged public var feelsLike: FeelsLikeData
    @NSManaged public var temp: TempData

}

extension DailyData : Identifiable {

}
