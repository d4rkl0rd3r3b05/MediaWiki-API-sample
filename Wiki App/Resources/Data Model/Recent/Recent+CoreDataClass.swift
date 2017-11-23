//
//  Recent+CoreDataClass.swift
//  
//
//  Created by Mayank Gupta on 04/11/17.
//
//

import Foundation
import CoreData


public class Recent: NSManagedObject {
    class func saveToRecent(searchText: String, response: Data) {
        var requiredRecent : Recent?
        
        // Get all items from Recent Entity ordered by Date
        if let recents = CoreDataHandler.sharedInstance.getItemsInEntity("Recent", withSortDescriptorKey : "searchTime") as? [Recent]{
            // Filter above collection with item.searchText = searchText
            var currentSearch = recents.filter{ $0.searchText == searchText }
            
            // If filtered collection have any item then modified first item and delete rest of the items
            if currentSearch.count > 0 {
                requiredRecent = currentSearch[0]
                
                for item in currentSearch[1..<currentSearch.count] {
                   let _ = CoreDataHandler.sharedInstance.deleteItem(item)
                }
            }else{
                if recents.count >= RECENT_SAVE_LIMIT {
                    requiredRecent = recents[RECENT_SAVE_LIMIT - 1]
                }
                if recents.count > RECENT_SAVE_LIMIT {
                    requiredRecent = recents[RECENT_SAVE_LIMIT - 1]
                    
                    for item in currentSearch[RECENT_SAVE_LIMIT..<recents.count] {
                        _ = CoreDataHandler.sharedInstance.deleteItem(item)
                    }
                }else {
                    // Else create a new recent item with input search text and response
                    requiredRecent = CoreDataHandler.sharedInstance.createNewObjectInEntity(entityName: "Recent") as? Recent
                }
            }
        }else {
            // Else create a new recent item with input search text and response
            requiredRecent = CoreDataHandler.sharedInstance.createNewObjectInEntity(entityName: "Recent") as? Recent
        }
        
        // Setting data in core data item
        requiredRecent?.searchText = searchText
        requiredRecent?.searchTime = Date()
        requiredRecent?.response = response
        
        _ = CoreDataHandler.sharedInstance.savePrivateContext()
    }
}
