//
//  DB_Weather+CoreDataProperties.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//
//

import Foundation
import CoreData


extension DB_Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DB_Weather> {
        return NSFetchRequest<DB_Weather>(entityName: "DB_Weather")
    }

    @NSManaged public var name: String
    @NSManaged public var coord: Data
    @NSManaged public var wind: Data
    @NSManaged public var weather: Data
    @NSManaged public var main: Data

}
