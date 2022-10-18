//
//  TemperatureFormatter.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import Foundation

extension Double {
	
	//MARK: - Temperature formatter
	var formattedTemperature: String? {
		return measurementFormatter.string(from: Measurement(value: self, unit: UnitTemperature.celsius))
	}
	
	//MARK: - Wind formatter
	var formattedWind: String? {
		return measurementFormatter.string(from: Measurement(value: self, unit: UnitSpeed.metersPerSecond))
	}
	
	// MARK: - Humidity formatter
	var formattedHumidity: String? {
		
		let percentFormatter: NumberFormatter = {
			let formatter = NumberFormatter()
			formatter.numberStyle = .percent
			formatter.multiplier = 1
			return formatter
		}()
		
		return percentFormatter.string(from: NSNumber(value: self))
	}

	// MARK: - Measurement Formatter
	private var measurementFormatter: MeasurementFormatter {
		let formatter = MeasurementFormatter()
		formatter.unitStyle = .medium
		formatter.numberFormatter.maximumFractionDigits = 0
		return formatter
	}
}
