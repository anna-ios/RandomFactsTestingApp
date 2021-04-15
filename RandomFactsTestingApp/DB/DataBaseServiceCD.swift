//
//  DataBaseService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 30/01/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import CoreData
import Foundation

class DataBaseServiceCD {
    
    lazy var readCoreData: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    lazy var newCoreData: NSManagedObjectContext = {
        let moc = persistentContainer.newBackgroundContext()
        return moc
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestingResultCD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
