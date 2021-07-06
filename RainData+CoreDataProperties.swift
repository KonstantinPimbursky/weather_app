//
//  RainData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 06.07.2021.
//
//

import Foundation
import CoreData


extension RainData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RainData> {
        return NSFetchRequest<RainData>(entityName: "RainData")
    }

    @NSManaged public var oneHour: String
    @NSManaged public var curent: CurrentData

}

extension RainData : Identifiable {

}
