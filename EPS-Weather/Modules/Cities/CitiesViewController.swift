//
//  CitiesViewController.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 14/10/2022.
//

import UIKit
import CoreLocation

class CitiesViewController: UIViewController {
	
	@IBOutlet private weak var tableview: UITableView! {
		didSet {
			tableview.dataSource = self
			tableview.delegate = self
			tableview.register(UINib(nibName: CityTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
		}
	}
	
	private var weathers: [WeatherResponse] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = Constants.cities_title
		self.navigationController?.navigationBar.prefersLargeTitles = true
		fetchWeathers()
	}
	
	private func fetchWeathers() {
		let viewModel = WeatherViewModel()
		DispatchQueue.main.async {
			viewModel.getWeather(params: CLLocationCoordinate2DMake(48.11220330007356, -1.6822433953343767)) { result in
				switch result {
				case .success(let weather):
					self.weathers.append(weather)
					self.tableview.reloadData()
				case .failure(let error):
					print(error)
				}
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? AddCityViewController {
			destination.delegate = self
		}
	}
}

// MARK: - TableView Protocols
extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return weathers.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as? CityTableViewCell
		else { return UITableViewCell() }
		cell.configure(with: self.weathers[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}


extension CitiesViewController: AddCityViewControllerDelegate {
	func didAdd(weather: WeatherResponse) {
		self.weathers.append(weather)
		self.tableview.reloadData()
	}
}
