//
//  AddCityViewController.swift
//  EPS-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import UIKit
import MapKit

protocol AddCityViewControllerDelegate {
	func didShooseCity()
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
		
		let result = searchResults[indexPath.row]
		let searchRequest = MKLocalSearch.Request(completion: result)
		
		let search = MKLocalSearch(request: searchRequest)
		search.start { (response, error) in
			guard let coordinate = response?.mapItems[0].placemark.coordinate else {
				return
			}
			
			guard let name = response?.mapItems[0].name else {
				return
			}
			
			let lat = coordinate.latitude
			let lon = coordinate.longitude
			
			print(lat)
			print(lon)
			print(name)
			
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
