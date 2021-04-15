//
//  CatFact.swift
//  RandomFactsTestingApp
//
//  Created by Zelinskaya Anna on 01.04.2021.
//

import Foundation

struct CatFact : Codable {
	let id: String
	let type: String
	let text: String
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case type = "type"
		case text = "text"
	}
}
