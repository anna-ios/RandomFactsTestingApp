//
//  TestingResultCD+CoreDataClass.swift
//  RandomFactsTestingApp
//
//  Created by Zelinskaya Anna on 01.04.2021.
//
//

import Foundation
import CoreData

@objc(TestingResultCD)
public class TestingResultCD: NSManagedObject, Decodable {

	enum CodingKeys: String, CodingKey {
		case date
		case text
		case reversedText
		case time
	}
	
	required public init(from decoder: Decoder) throws {
		guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingManagedObjectContext
		}
		
		guard let description = NSEntityDescription.entity(forEntityName: "TestingResultCD", in: context) else {
			throw NSEntityDescriptionError.cantCreateDescriptionForEntityName
		}
		
		super.init(entity: description, insertInto: context)
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.date = try container.decode(Date.self, forKey: .date)
		self.text = try container.decode(String.self, forKey: .text)
		self.reversedText = try container.decode(String.self, forKey: .reversedText)
		self.time = try container.decode(String.self, forKey: .time)
	}
	
	public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
	
}
