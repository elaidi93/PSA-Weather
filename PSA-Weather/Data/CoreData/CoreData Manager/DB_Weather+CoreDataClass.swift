//
//  DB_Weather+CoreDataClass.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//
//

import CoreData
import UIKit

@objc(DB_Weather)
public class DB_Weather: NSManagedObject {
	
	private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	// Fetch weathers
	func fetchWeathers() -> [DB_Weather]? {
		return try? context.fetch(DB_Weather.fetchRequest())
	}
	
	private func deleteWeathers() {
		guard let weathers = try? context.fetch(DB_Weather.fetchRequest())
		else { return }
		
		for weather in weathers {
			context.delete(weather)
		}
		try? context.save()
	}
	
	func delete(with id: Int) {
		guard let weather = self.fetchWeathers()?.first(where: { $0.id == id })
		else { return }
		
		context.delete(weather)
		
		try? context.save()
	}
	
	func insert(weather: WeatherResponse) {
		let dbWeather = DB_Weather(context: context)
		dbWeather.name = weather.name
		do {
			dbWeather.weather = try JSONEncoder().encode(weather.weather)
			dbWeather.wind = try JSONEncoder().encode(weather.wind)
			dbWeather.coord = try JSONEncoder().encode(weather.coord)
			dbWeather.main = try JSONEncoder().encode(weather.main)
			
			try context.save()
		} catch(let error) { print(error) }
	}
}

extension DB_Weather {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<DB_Weather> {
		return NSFetchRequest<DB_Weather>(entityName: "DB_Weather")
	}

	@NSManaged public var id: Int64
	@NSManaged public var name: String
	@NSManaged public var coord: Data
	@NSManaged public var wind: Data
	@NSManaged public var weather: Data
	@NSManaged public var main: Data

}
