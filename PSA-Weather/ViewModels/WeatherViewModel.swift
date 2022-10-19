//
//  WeatherViewModel.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 17/10/2022.
//

import Foundation
import CoreLocation
import APIFramework

class WeatherViewModel {
	
	private var dbWeatherManager: DB_Weather?
	
	init(dbWeatherManager: DB_Weather) {
		self.dbWeatherManager = dbWeatherManager
	}
	
	func getWeather(params: CLLocationCoordinate2D, completionHandler: @escaping (Result<WeatherResponse, Error>) -> ()) {
		
		APIRequest.shared.request(url: generateUrl(with: params)) { result in
			switch result {
			case .success(let data):
				do {
					let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
					DispatchQueue.main.async {
						self.dbWeatherManager?.insert(weather: weather)
						completionHandler(.success(weather))
					}
				} catch(let error) {
					completionHandler(.failure(error))
				}
			case .failure(let error):
				completionHandler(.failure(error))
			}
		}
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
	
	private func generateUrl(with coord: CLLocationCoordinate2D) -> URL? {
		return URL(string: "\(Constants.api_url.rawValue)?lat=\(coord.latitude)&lon=\(coord.longitude)&appid=\(Constants.api_key.rawValue)&units=metric")
	}
}
