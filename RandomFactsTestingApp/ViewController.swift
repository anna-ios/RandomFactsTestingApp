//
//  ViewController.swift
//  RandomFactsTestingApp
//
//  Created by Zelinskaya Anna on 01.04.2021.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var testingButton: UIButton!
	
	var text: String = ""
	
	@IBAction func tapTestingButton(_ sender: Any) {
		performSegue(withIdentifier: "segueIdentifier", sender: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		testingButton.isHidden = true
		
		let path = "https://cat-fact.herokuapp.com/facts/random"
		let networkClient = NetworkClient()
		networkClient.sendRequest(path: path) { (result: Result<CatFact,Error>) in
			switch result {
			case .success(let catFact):
				self.text = catFact.text
				self.textLabel.text = catFact.text
				self.testingButton.isHidden = false
				print(catFact)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueIdentifier" {
			let controller = segue.destination as! TestingViewController
			controller.text = text
		}
	}
	
}

