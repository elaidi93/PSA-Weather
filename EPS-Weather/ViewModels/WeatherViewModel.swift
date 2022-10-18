//
//  WeatherViewModel.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 17/10/2022.
//

import Foundation

class WeatherViewModel {
	
	func getWeather(params: Coordinate, completionHandler: @escaping (Result<WeatherResponse, Error>) -> ()) {
		
		guard let url = URL(string: "\(Constants.api_url)?lat=\(params.lat)&lon=\(params.lon)&appid=\(Constants.api_key)&units=metric")
		else { return }
		
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			
			if let error {
				completionHandler(.failure(error))
			} else if let data {
				do {
					let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
					
					DispatchQueue.main.async {
						completionHandler(.success(weather))
					}
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		task.resume()
	}
}
