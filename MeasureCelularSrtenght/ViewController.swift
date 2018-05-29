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
	
	private var timer: Timer!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		initTimer()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillAppear(animated)
		timer.invalidate()
	}

	private func initTimer() {
		timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateSignalMeasure), userInfo: nil, repeats: true)
		timer.fire()
	}
	
	@objc func updateSignalMeasure() {
		let sinalValue = getSignalStrength()
		celularStrenghtLabel.text = String(sinalValue)
		print("timer updated")
	}
	
}

extension ViewController {
	
	func getSignalStrength() -> Int {
		
		let application = UIApplication.shared
		let statusBarView = application.value(forKey: "statusBar") as! UIView
		
		guard let foregroundView = statusBarView.value(forKey: "foregroundView") as? UIView else {
			return 0
		}
		
		guard let barSignalStrenghtStringClass = NSClassFromString("UIStatusBarSignalStrengthItemView") else {
			return 0
		}

		let foregroundViewSubviews = foregroundView.subviews
		
		var dataNetworkItemView:UIView!
		
		var signalValue = 0
		
		for subview in foregroundViewSubviews {
			if subview.isKind(of: barSignalStrenghtStringClass) {
				dataNetworkItemView = subview
				signalValue = dataNetworkItemView.value(forKey: "signalStrengthRaw") as! Int
			}
		}
		
		return signalValue
		
	}
}
