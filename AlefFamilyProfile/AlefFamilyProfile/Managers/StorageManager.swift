//
//  StorageManager.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit
import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    var managedObjectContext: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to cast UIApplication.shared.delegate to AppDelegate")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func deleteChild(_ object: Child) throws {
        managedObjectContext.delete(object)
        do {
            try managedObjectContext.save()
        } catch {
            throw StorageError.deletingError
        }
    }
    
    
    func retrieveAllChildren() throws -> [Child] {
        do {
            let fetchRequest = NSFetchRequest<Child>(entityName: "Child")
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            throw StorageError.retrieveError
        }
    }
    
    
    func deleteAllChildren() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Child.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            try managedObjectContext.save()
        } catch {
            throw StorageError.clearStorageError
        }
    }
}
