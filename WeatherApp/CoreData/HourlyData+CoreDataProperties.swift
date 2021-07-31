//
//  HourlyData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 18.07.2021.
//
//

import Foundation
import CoreData


extension HourlyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyData> {
        return NSFetchRequest<HourlyData>(entityName: "HourlyData")
    }

    @NSManaged public var clouds: Int16
    @NSManaged public var dt: Double
    @NSManaged public var feelsLike: Double
    @NSManaged public var pop: Double
    @NSManaged public var temp: Double
    @NSManaged public var windDeg: Int16
    @NSManaged public var windSpeed: Double
    @NSManaged public var forecast: ForecastData
    @NSManaged public var weather: WeatherData

}

extension HourlyData : Identifiable {

}
