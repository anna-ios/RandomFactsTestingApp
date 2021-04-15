//
//  TestingResultCD+CoreDataProperties.swift
//  RandomFactsTestingApp
//
//  Created by Zelinskaya Anna on 01.04.2021.
//
//

import Foundation
import CoreData

extension TestingResultCD {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<TestingResultCD> {
		return NSFetchRequest<TestingResultCD>(entityName: "TestingResultCD")
	}

	@NSManaged public var date: Date?
	@NSManaged public var text: String?
	@NSManaged public var reversedText: String?
	@NSManaged public var time: String?

}

extension TestingResultCD : Identifiable {

}
