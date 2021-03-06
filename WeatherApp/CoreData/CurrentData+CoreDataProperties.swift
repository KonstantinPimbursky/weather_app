//
//  CurrentData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 27.07.2021.
//
//

import Foundation
import CoreData


extension CurrentData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentData> {
        return NSFetchRequest<CurrentData>(entityName: "CurrentData")
    }

    @NSManaged public var dt: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var sunrise: Double
    @NSManaged public var sunset: Double
    @NSManaged public var temp: Double
    @NSManaged public var windSpeed: Int16
    @NSManaged public var forecast: ForecastData
    @NSManaged public var weather: WeatherData

}

extension CurrentData : Identifiable {

}
