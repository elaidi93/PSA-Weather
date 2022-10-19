//
//  CitiesViewController.swift
//  PSA-Weather
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
	
	private var weathers = [WeatherResponse]()
	private let viewModel = WeatherViewModel(dbWeatherManager: DB_Weather())

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = Constants.cities_title
		self.navigationController?.navigationBar.prefersLargeTitles = true
		fetchWeathers()
	}
	
	private func fetchWeathers() {

		do {
			weathers = try viewModel.getWeathers()
			self.tableview.reloadData()
		} catch(let error) { print(error) }
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? AddCityViewController {
			destination.delegate = self
			destination.viewModel = viewModel
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
		cell.configure(with:self.weathers[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let detailsVC = UIStoryboard(name: "WeatherDetails", bundle: nil).instantiateInitialViewController() as? WeatherDetailsViewController
		else { return }
		
		detailsVC.weather = weathers[indexPath.row]
		self.navigationController?.pushViewController(detailsVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			viewModel.delete(weather: weathers[indexPath.row])
			weathers.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}


extension CitiesViewController: AddCityViewControllerDelegate {
	func didAdd(weather: WeatherResponse) {
		self.weathers.append(weather)
		self.tableview.reloadData()
	}
}
