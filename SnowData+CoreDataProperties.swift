//
//  SnowData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 28.06.2021.
//
//

import Foundation
import CoreData


extension SnowData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SnowData> {
        return NSFetchRequest<SnowData>(entityName: "SnowData")
    }

    @NSManaged public var oneHour: String?
    @NSManaged public var current: CurrentData

}

extension SnowData : Identifiable {

}
