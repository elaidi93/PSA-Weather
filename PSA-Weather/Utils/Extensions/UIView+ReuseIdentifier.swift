//
//  UIView+ReuseIdentifier.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import Foundation

protocol ReuseIdentifierProtocol {
	static var reuseIdentifier: String { get }
}

extension ReuseIdentifierProtocol {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}
