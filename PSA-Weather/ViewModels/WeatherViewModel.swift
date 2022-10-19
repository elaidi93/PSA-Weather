//
//  WeatherViewModel.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 17/10/2022.
//

import Foundation
import CoreLocation

class WeatherViewModel {
	
	private var dbWeatherManager: DB_Weather?
	
	init(dbWeatherManager: DB_Weather) {
		self.dbWeatherManager = dbWeatherManager
	}
	
	func getWeather(params: CLLocationCoordinate2D, completionHandler: @escaping (Result<WeatherResponse, Error>) -> ()) {
		
		guard let url = URL(string: "\(Constants.api_url.rawValue)?lat=\(params.latitude)&lon=\(params.longitude)&appid=\(Constants.api_key.rawValue)&units=metric")
		else { return }
		
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			
			if let error {
				completionHandler(.failure(error))
				
			} else if let data {
				do {
					let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
					DispatchQueue.main.async {
						self.dbWeatherManager?.insert(weather: weather)
						completionHandler(.success(weather))
					}
				} catch(let error) {
					completionHandler(.failure(error))
				}
			}
		}
		task.resume()
	}
	
	func getWeathers() throws -> [WeatherResponse] {
		
		guard let dbWeathers = dbWeatherManager?.fetchWeathers()
		else { return [] }
		
		return try dbWeathers.map {
			WeatherResponse(id: Int($0.id),
							name: $0.name,
							weather: try JSONDecoder().decode([WeatherResponse.Weather].self, from: $0.weather),
							main: try JSONDecoder().decode(WeatherResponse.Main.self, from: $0.main),
							coord: try JSONDecoder().decode(WeatherResponse.WeatherCoordinate.self, from: $0.coord),
							wind: try JSONDecoder().decode(WeatherResponse.Wind.self, from: $0.wind))
		}
	}
	
	func delete(weather: WeatherResponse) {
		dbWeatherManager?.delete(with: weather.id)
	}
}
