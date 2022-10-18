//
//  CityTableViewCell.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import UIKit

class CityTableViewCell: UITableViewCell, ReuseIdentifierProtocol {
	
	@IBOutlet private weak var cityName: UILabel!
	@IBOutlet private weak var weatherDegree: UILabel!
	@IBOutlet private weak var weatherIcon: UIImageView!
	
	@IBOutlet private weak var container: UIView! {
		didSet {
			container.layer.cornerRadius = 8
			container.addShadow()
		}
	}

	func configure(with weather: WeatherResponse) {
		cityName.text = weather.name
		weatherDegree.text = String(weather.main.temp)
		weatherIcon.image = Images(rawValue: weather.weather.first!.icon)?.image
	}

}
