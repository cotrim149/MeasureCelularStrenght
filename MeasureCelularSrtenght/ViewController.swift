//
//  ViewController.swift
//  MeasureCelularSrtenght
//
//  Created by Victor de Lima on 24/05/2018.
//  Copyright © 2018 Victor Cotrim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var celularStrenghtLabel: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let sinalValue = getSignalStrength()
		celularStrenghtLabel.text = String(sinalValue)
	}

}

extension ViewController {
	
	func getSignalStrength() -> Int {
		
		let application = UIApplication.shared
		let statusBarView = application.value(forKey: "statusBar") as! UIView
		
		guard let foregroundView = statusBarView.value(forKey: "foregroundView") as? UIView else {
			return 0
		}
		
		let foregroundViewSubviews = foregroundView.subviews
		
		var dataNetworkItemView:UIView!
		
		for subview in foregroundViewSubviews {
			if subview.isKind(of: NSClassFromString("UIStatusBarSignalStrengthItemView")!) {
				dataNetworkItemView = subview
				break
			} else {
				return 0 //NO SERVICE
			}
		}
		
		return dataNetworkItemView.value(forKey: "signalStrengthBars") as! Int
		
	}
}
