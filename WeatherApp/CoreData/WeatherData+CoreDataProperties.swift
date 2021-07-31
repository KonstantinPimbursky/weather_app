//
//  WeatherData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 18.07.2021.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var icon: String
    @NSManaged public var weatherDescription: String
    @NSManaged public var current: CurrentData
    @NSManaged public var daily: DailyData
    @NSManaged public var hourly: HourlyData

}

extension WeatherData : Identifiable {

}
