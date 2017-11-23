//
//  CoreDataHandler.swift
//  Wiki App
//
//  Created by Mayank Gupta on 04/11/17.
//  Copyright © 2017 Mayank Gupta. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler
{
    //MARK: - Class Methods
    class var sharedInstance: CoreDataHandler
    {
        _ = CoreDataHandler.__once
        return Static.instance!
    }
    
    //MARK: Singleton Specifiers
    fileprivate var context: NSManagedObjectContext
    var privateContext: NSManagedObjectContext
    
    struct Static
    {
        static var onceToken: Int = 0
        static var instance: CoreDataHandler? = nil
    }
    
    private static var __once: () = {
        Static.instance = CoreDataHandler()
    }()
    
    //MARK: - Basic Setup
    init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
    }
    
    func getBasicRequestForEntityNameInPrivateCase(_ entityName: String) -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        let entityMB = NSEntityDescription.entity(forEntityName: entityName, in:privateContext)
        fetchRequest.entity = entityMB
        
        return fetchRequest as! NSFetchRequest<NSManagedObject>
    }
    
    func createNewObjectInEntity(entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: privateContext)
    }
    
    //MARK: - Retrieval
    func getItemsInEntity(_ entityName: String, withSortDescriptorKey sortDescriptorKey: String? = nil, withKey key: String? = nil, withValue value: String? = nil) -> [NSManagedObject]? {
        let fetchRequest = getBasicRequestForEntityNameInPrivateCase(entityName)
        if key != nil && value != nil {
            fetchRequest.predicate = NSPredicate(format: "%@ = %@", key!, value!)
        }
        
        if sortDescriptorKey != nil {
            let primarySortDescriptor = NSSortDescriptor(key: "\(sortDescriptorKey!)", ascending: false)
            fetchRequest.sortDescriptors = [primarySortDescriptor]
        }
        
        var list : [NSManagedObject]?
        do {
            list = try privateContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as? [NSManagedObject]
        }
        catch {
            
        }
        
        return list
    }
    
    //MARK: - Deletion
    func deleteItem(_ item: NSManagedObject)  -> Bool {
        privateContext.delete(item)
        return savePrivateContext()
    }
    
    //MARK: Save In Context
    func savePrivateContext() ->Bool {
        //Persist new Property to datastore (via Managed Object Context Layer).
        var success:Bool
        do {
            try privateContext.save()
            try privateContext.parent?.save()
            success = true
        }
        catch {
            success = false
        }
        
        return success
    }
}
