//
//  WeatherData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 28.06.2021.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var weatherDescription: String
    @NSManaged public var icon: String
    @NSManaged public var hourly: HourlyData
    @NSManaged public var daily: DailyData
    @NSManaged public var current: CurrentData

}

extension WeatherData : Identifiable {

}
