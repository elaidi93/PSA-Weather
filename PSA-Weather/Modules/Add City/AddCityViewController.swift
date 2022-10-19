//
//  AddCityViewController.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import UIKit
import MapKit

protocol AddCityViewControllerDelegate {
	func didAdd(weather: WeatherResponse)
}

class AddCityViewController: UIViewController {
	
	@IBOutlet private weak var tableView: UITableView! {
		didSet {
			tableView.dataSource = self
			tableView.delegate = self
		}
	}
	
	var searchCompleter = MKLocalSearchCompleter()
	var searchResults = [MKLocalSearchCompletion]()
	
	var viewModel: WeatherViewModel?
	var delegate: AddCityViewControllerDelegate?
	
	private lazy var searchControl: UISearchController = {
		let search = UISearchController(searchResultsController: nil)
		search.searchResultsUpdater = self
		search.obscuresBackgroundDuringPresentation = false
		search.searchBar.placeholder = Constants.searchBar_placeholder
		
		return search
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		searchCompleter.delegate = self
		self.title = Constants.addCity_title
		self.navigationItem.searchController = self.searchControl
		self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - TableView Protocols
extension AddCityViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResults.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let searchResult = searchResults[indexPath.row]
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		
		cell.textLabel?.text = searchResult.title
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let searchRequest = MKLocalSearch.Request(completion: searchResults[indexPath.row])
		MKLocalSearch(request: searchRequest).start { (response, error) in
			guard let coordinate = response?.mapItems[0].placemark.coordinate
			else { return }
			
			self.viewModel?.getWeather(params: coordinate) { result in
				switch result {
				case .success(let weather):
					self.delegate?.didAdd(weather: weather)
					self.navigationController?.popViewController(animated: true)
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}

// MARK: - SearchBar Protocols
extension AddCityViewController: MKLocalSearchCompleterDelegate {
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		searchResults = completer.results
		tableView.reloadData()
	}
}

extension AddCityViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		searchCompleter.queryFragment = searchController.searchBar.text ?? ""
	}
}
