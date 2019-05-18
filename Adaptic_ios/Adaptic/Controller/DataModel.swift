//
//  DataModel.swift
//  Adaptic
//
//  Created by Benji Magnelli on 4/6/19.
//  Copyright © 2019 Benji Magnelli. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataModel {
    func getStoredTickers() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WatchItem")
        request.returnsObjectsAsFaults = false
        
        do {
            let arrayOfData = try managedContext.fetch(request)
            
            if arrayOfData.isEmpty {
                myTickers.append("aapl")
                numberOfTickers = 1
            }
            else {
               
                numberOfTickers = arrayOfData.count
                
                for data in arrayOfData as! [NSManagedObject] {
                    let ticker = data.value(forKey: "ticker") as! String
                    
                    myTickers.append(ticker)
                    
                }
                
            }
            
            
        }
            
        catch let error as NSError {
            print("Error in getStoredTickers: \(error.localizedDescription)")
        }
        
    }
    
    
    func saveTicker(ticker: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let watchItemEntity = NSEntityDescription.entity(forEntityName: "WatchItem", in: managedContext)!
        let item = NSManagedObject(entity: watchItemEntity, insertInto: managedContext)
        
        item.setValue(ticker, forKey: "ticker")
        
        
        do {
            try managedContext.save()
            print("Added")
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        
        
    }
    
    func deleteTicker(ticker: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WatchItem")
        request.predicate = NSPredicate(format: "ticker = %@", ticker )
        
        do
        {
            let test = try managedContext.fetch(request)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
                print("Removed")
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
        
//        if let result = try? managedContext.fetch(request) {
//            for object in result {
//                managedContext.delete(object as! NSManagedObject)
//            }
//        }
//
//        do {
//            try managedContext.save()
//            print("Deleted")
//        }
//
//        catch let error as NSError {
//            print("Error: \(error.localizedDescription)")
//        }
    }
    
    

}
