//
//  AddCityViewController.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import UIKit
import MapKit

protocol AddCityViewControllerDelegate {
	func didAdd(weather: WeatherResponse)
}

class AddCityViewController: UIViewController {
	
	@IBOutlet private weak var searchBar: UISearchBar!
	@IBOutlet private weak var tableView: UITableView! {
		didSet {
			tableView.dataSource = self
			tableView.delegate = self
		}
	}
	
	var searchCompleter = MKLocalSearchCompleter()
	var searchResults = [MKLocalSearchCompletion]()
	
	let viewModel = WeatherViewModel()
	var delegate: AddCityViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

		searchCompleter.delegate = self
    }
}

extension AddCityViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResults.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let searchResult = searchResults[indexPath.row]
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		
		//Set the content of the cell to our searchResult data
		cell.textLabel?.text = searchResult.title
		cell.detailTextLabel?.text = searchResult.subtitle
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let searchRequest = MKLocalSearch.Request(completion: searchResults[indexPath.row])
		MKLocalSearch(request: searchRequest).start { (response, error) in
			guard let coordinate = response?.mapItems[0].placemark.coordinate
			else { return }
			
			self.viewModel.getWeather(params: coordinate) { result in
				switch result {
				case .success(let weather):
					self.delegate?.didAdd(weather: weather)
					self.dismiss(animated: true)
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}

extension AddCityViewController: MKLocalSearchCompleterDelegate, UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		searchCompleter.queryFragment = searchText
	}
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		searchResults = completer.results
		tableView.reloadData()
	}
}
