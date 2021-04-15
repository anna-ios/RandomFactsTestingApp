//
//  Service.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 05/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation
import CoreData

protocol ServiceCDInput {
	
	func read() -> NSFetchedResultsController<TestingResultCD>
	
	func write(from data: Data)
	
}


class ServiceCD {
	
	private unowned var readCoreData: NSManagedObjectContext
	
	let databaseService: DataBaseServiceCD
	
	init(databaseService: DataBaseServiceCD) {
		self.readCoreData = databaseService.readCoreData//1
		self.databaseService = databaseService
	}
}

extension ServiceCD : ServiceCDInput {
	
	
	func read() -> NSFetchedResultsController<TestingResultCD> {
		
		let request = NSFetchRequest<TestingResultCD>(entityName: "TestingResultCD")
		request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
		
		let fetchedResultsController = NSFetchedResultsController<TestingResultCD>(fetchRequest: request,
													managedObjectContext:readCoreData,
													sectionNameKeyPath:nil,
													cacheName:nil)
		
		return fetchedResultsController
	}
	
	func write(from data: Data){
		
		let writeCoreData = databaseService.newCoreData
		
		writeCoreData.perform { [weak self] in
			do {
				let decoder = JSONDecoder()
				decoder.userInfo[CodingUserInfoKey.managedObjectContext] = writeCoreData
				decoder.dateDecodingStrategy = .iso8601
				
				let result = try decoder.decode(TestingResultCD.self, from: data)
				writeCoreData.insert(result)
				
				try writeCoreData.save()
				self?.readCoreData.perform {
					self?.readCoreData.refreshAllObjects()
				}
			} catch {
				print(error)
			}
		}
	}
}
