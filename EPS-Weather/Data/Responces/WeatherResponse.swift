//
//  WeatherResponse.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 17/10/2022.
//

import Foundation

struct WeatherResponse: Decodable {
	let id: Int
	let name: String
	let weather: [Weather]
	let main: Main
	let coord: WeatherCoordinate
	let wind: Wind
}

struct Weather: Codable {
	let description: String
	let icon: String
	let main: String
}

struct Main: Codable {
	let temp: Double
	let pressure: Double
	let humidity: Double
}

struct Wind: Codable {
	let speed: Double
}

struct WeatherCoordinate: Codable {
	let longitude: Double
	let latitude: Double
	
	enum CodingKeys: String, CodingKey {
		case latitude = "lat",
			 longitude = "lon"
	}
}
