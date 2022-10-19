//
//  WeatherViewModelTests.swift
//  PSA-WeatherTests
//
//  Created by Hamza EL Aidi on 19/10/2022.
//

import Foundation
import CoreLocation

import XCTest
@testable import PSA_Weather

final class WeatherViewModelTests: XCTestCase {
	
	let viewModel = WeatherViewModel(dbWeatherManager: DB_Weather())
	
	// Test call API and save data
	func testSaveData() {
		viewModel.getWeather(params: CLLocationCoordinate2D(latitude: 48.117266, longitude: -1.6777926)) { result in
			switch result {
			case .success(let weather):
				XCTAssertEqual(weather.name, "Rennes")
			default: break
			}
		}
	}
}
