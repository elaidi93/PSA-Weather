//
//  WeatherDetailsViewController.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
	
	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet private weak var temperator: UILabel!
	@IBOutlet private weak var city: UILabel!
	@IBOutlet private weak var humidity: UILabel!
	@IBOutlet private weak var wind: UILabel!
	@IBOutlet private weak var infos: UILabel!
	
	var weather: WeatherResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = Constants.details_title.rawValue
        refreshUI()
    }
	
	private func refreshUI() {
		icon.image = UIImage(named: weather?.weather.first?.icon ?? "01d")
		city.text = weather?.name
		temperator.text = weather?.main.temp.formattedTemperature
		humidity.text = weather?.main.humidity.formattedHumidity
		wind.text = weather?.wind.speed.formattedWind
		infos.text = weather?.weather.first?.description
	}

}
