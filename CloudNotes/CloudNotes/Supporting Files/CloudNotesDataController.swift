//
//  DataController.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/16.
//

import Foundation
import CoreData

class CloudNotesDataController {
    
    static let shared = CloudNotesDataController()
    
    private let handler: (() -> Void)?
    
    // MARK: - Core Data stack
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "CloudNotes")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self.handler?()
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(completionHandler: (() -> Void)? = nil) {
        self.handler = completionHandler
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        let result = try? context.fetch(request)
        return result ?? []
    }
    
    func create(entity name: String, objectHandler: (NSManagedObject) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: name, in: context) else {
            return
        }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        objectHandler(managedObject)
        try? context.save()
    }
    
    func delete(object: NSManagedObject) {
        context.delete(object)
        try? context.save()
    }
    
    func update<T: NSManagedObject>(request: NSFetchRequest<T>, objectHandler: (NSManagedObject) -> Void) {
        guard let managedObject = try? context.fetch(request).first else { return }
        objectHandler(managedObject)
        try? context.save()
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
