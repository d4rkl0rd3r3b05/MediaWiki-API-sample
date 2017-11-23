//
//  Recent+CoreDataProperties.swift
//  
//
//  Created by Mayank Gupta on 04/11/17.
//
//

import Foundation
import CoreData


extension Recent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recent> {
        return NSFetchRequest<Recent>(entityName: "Recent")
    }

    @NSManaged public var response: Data?
    @NSManaged public var searchText: String?
    @NSManaged public var searchTime: Date?

}
