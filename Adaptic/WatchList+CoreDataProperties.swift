//
//  WatchList+CoreDataProperties.swift
//  
//
//  Created by Benji Magnelli on 2/15/19.
//
//

import Foundation
import CoreData


extension WatchList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchList> {
        return NSFetchRequest<WatchList>(entityName: "WatchList")
    }

    @NSManaged public var ticker: String?

}
