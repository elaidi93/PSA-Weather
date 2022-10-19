//
//  APIRequest.swift
//  APIFramework
//
//  Created by Hamza EL Aidi on 19/10/2022.
//

import Foundation

public class APIRequest {
	
	public static let shared = APIRequest()
	
	public func request(url: URL?, completionHandler: @escaping (Result<Data, Error>) -> ()) {
		
		guard let url
		else { return }
		
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			
			if let error {
				completionHandler(.failure(error))
			} else if let data {
				completionHandler(.success(data))
			}
		}
		task.resume()
	}
}
