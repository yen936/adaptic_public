//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Benji Magnelli on 2/15/19.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "WatchList")
    }

    @NSManaged public var ticker: String?

}
