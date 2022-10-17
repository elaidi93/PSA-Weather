//
//  CitiesViewController.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 14/10/2022.
//

import UIKit

class CitiesViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let viewModel = WeatherViewModel()
		DispatchQueue.main.async {
			
			viewModel.getWeather(params: Coordinate(lat: 48.11220330007356, lon: -1.6822433953343767)) { result in
				switch result {
				case .success(let weather):
					print(weather)
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}

