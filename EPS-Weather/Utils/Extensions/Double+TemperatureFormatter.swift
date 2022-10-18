//
//  TemperatureFormatter.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import Foundation

extension Double {
	
	var formattedTemperature: String? {
		let measurementFormatter: MeasurementFormatter = {
			let formatter = MeasurementFormatter()
			formatter.unitStyle = .short
			formatter.numberFormatter.maximumFractionDigits = 0
			formatter.unitOptions = .temperatureWithoutUnit
			return formatter
		}()
		
		return measurementFormatter.string(from: Measurement(value: self, unit: UnitTemperature.celsius))
	}
}
