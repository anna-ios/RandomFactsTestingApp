//
//  TestResult.swift
//  RandomFactsTestingApp
//
//  Created by Zelinskaya Anna on 07.04.2021.
//

import Foundation

struct TestResult : Codable {
	var date: Date?
	var text: String?
	var reversedText: String?
	var time: String?
	
	enum CodingKeys: String, CodingKey {
		case date
		case text
		case reversedText
		case time
	}
	
}
