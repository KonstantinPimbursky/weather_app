//
//  FeelsLikeData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 18.07.2021.
//
//

import Foundation
import CoreData


extension FeelsLikeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeelsLikeData> {
        return NSFetchRequest<FeelsLikeData>(entityName: "FeelsLikeData")
    }

    @NSManaged public var day: Double
    @NSManaged public var night: Double
    @NSManaged public var daily: DailyData

}

extension FeelsLikeData : Identifiable {

}
