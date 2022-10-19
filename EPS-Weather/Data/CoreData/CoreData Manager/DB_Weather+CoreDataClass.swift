//
//  DB_Weather+CoreDataClass.swift
//  EPS-Weather
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
	
	func insert(weather: WeatherResponse) {
		let dbWeather = DB_Weather(context: context)
		dbWeather.name = weather.name
		do {
			dbWeather.weather = try JSONEncoder().encode(weather.weather)
			dbWeather.wind = try JSONEncoder().encode(weather.wind)
			dbWeather.coord = try JSONEncoder().encode(weather.coord)
			dbWeather.main = try JSONEncoder().encode(weather.main)
			
			try? context.save()
		} catch(let error) { print(error) }
	}
}
