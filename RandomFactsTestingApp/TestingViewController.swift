//
//  TestingViewController.swift
//  RandomFactsTestingApp
//
//  Created by Zelinskaya Anna on 12.04.2021.
//

import UIKit

class TestingViewController: UIViewController {
	
	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var reversedTextLabel: UILabel!
	@IBOutlet weak var testTime: UILabel!
	@IBOutlet weak var startTestingButton: UIButton!
	
	var dataBaseServiceCD: DataBaseServiceCD!
	lazy var serviceCD = makeServiceCD()
	let manager: TextManager = TextManager()
	var text: String = ""
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.dataBaseServiceCD = DataBaseServiceCD()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textLabel.text = text
		reversedTextLabel.text = ""
		
		let result = self.serviceCD.read()
		try? result.performFetch()
		guard let fetchedObjects = result.fetchedObjects else {
			return
		}
		if let fetchedObject = fetchedObjects.first {
			reversedTextLabel.text = fetchedObject.reversedText
			textLabel.text = fetchedObject.text
			testTime.text = fetchedObject.time
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		let result = TestResult(date:Date(), text:self.textLabel.text, reversedText:reversedTextLabel.text, time:testTime.text)
		
		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601
		let encodedData = try? encoder.encode(result)
										
		if let someData = encodedData, someData.count > 0 {
			self.serviceCD.write(from: someData)
		}
	}
	
	@IBAction func startTesting(_ sender: Any) {
		self.startUppercasedTesting()
	}
	
	func makeServiceCD() -> ServiceCDInput {
		let service = ServiceCD(databaseService: self.dataBaseServiceCD)
		return service
	}
	
	func startUppercasedTesting() {
		let dispatchGroup = DispatchGroup()
		DispatchQueue.global().async(group: dispatchGroup) {
			let result = self.manager.reverseText(self.text)
			DispatchQueue.main.async {
				self.textLabel.text = self.text
				self.testTime.text = result.time
				self.reversedTextLabel.text = result.reversedText
			}
		}
	}
	
}
