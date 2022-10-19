//
//  UIView+Shadow.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 18/10/2022.
//

import UIKit

extension UIView {
	
	func addShadow() {
		self.layer.shadowColor = UIColor.darkGray.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 2)
		self.layer.shadowOpacity = 0.3
		self.layer.shadowRadius = 4
	}
	
}
