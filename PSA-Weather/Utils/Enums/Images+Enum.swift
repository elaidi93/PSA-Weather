//
//  Images.swift
//  PSA-Weather
//
//  Created by Hamza EL Aidi on 17/10/2022.
//

import UIKit

enum Images: String {
	case img01d = "01d",
		 img01n = "01n",
		 img02d = "02d",
		 img02n = "02n",
		 img03d = "03d",
		 img03n = "03n",
		 img04d = "04d",
		 img04n = "04n",
		 img09d = "09d",
		 img09n = "09n",
		 img10d = "10d",
		 img10n = "10n",
		 img11d = "11d",
		 img11n = "11n",
		 img13d = "13d",
		 img13n = "13n",
		 img50d = "50d",
		 img50n = "50n"
	
	var image: UIImage? {
		switch self {
		case .img01d:
			return UIImage(named: Images.img01d.rawValue)
		case .img01n:
			return UIImage(named: Images.img01n.rawValue)
		case .img02d:
			return UIImage(named: Images.img02d.rawValue)
		case .img02n:
			return UIImage(named: Images.img02n.rawValue)
		case .img03d:
			return UIImage(named: Images.img03d.rawValue)
		case .img03n:
			return UIImage(named: Images.img03n.rawValue)
		case .img04d:
			return UIImage(named: Images.img04d.rawValue)
		case .img04n:
			return UIImage(named: Images.img04n.rawValue)
		case .img09d:
			return UIImage(named: Images.img09d.rawValue)
		case .img09n:
			return UIImage(named: Images.img09n.rawValue)
		case .img10d:
			return UIImage(named: Images.img10d.rawValue)
		case .img10n:
			return UIImage(named: Images.img10n.rawValue)
		case .img11d:
			return UIImage(named: Images.img11d.rawValue)
		case .img11n:
			return UIImage(named: Images.img11n.rawValue)
		case .img13d:
			return UIImage(named: Images.img13d.rawValue)
		case .img13n:
			return UIImage(named: Images.img13n.rawValue)
		case .img50d:
			return UIImage(named: Images.img50d.rawValue)
		case .img50n:
			return UIImage(named: Images.img50n.rawValue)
		}
	}
}
