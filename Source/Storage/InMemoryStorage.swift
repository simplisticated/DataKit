//
//  InMemoryStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class InMemoryStorage: Storage {
    
    // MARK: Class variables & properties
    
    static var tables: [String : [Object]]!
    
    
    // MARK: Public class methods
    
    public override class func initializeStorage() {
        // Initialize tables collection
        
        tables = [String : [Object]]()
    }
    
    public override class func getOrCreateObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier uniqueIdentifier: String, andCompletion completion: ((object: ObjectClass) -> Void)?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            var table = getOrCreateTableForObjectWithType(ObjectClass.self)
            var resultObject: ObjectClass? = findObjectWithUniqueIdentifier(uniqueIdentifier, inTable: table)
            
            if resultObject == nil {
                resultObject = ObjectClass()
                table.append(resultObject!)
            }
            
            dispatch_async(dispatch_get_main_queue(), { 
                completion?(object: resultObject!)
            })
        }
    }
    
    public override class func updateObject<ObjectClass where ObjectClass: Object>(object: ObjectClass, withCompletion completion: ((object: ObjectClass) -> Void)?) {
    }
    
    public override class func deleteObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier uniqueIdentifier: String, andCompletion completion: (() -> Void)?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            var table = getOrCreateTableForObjectWithType(ObjectClass.self)
            let indexOfObject = indexOfObjectWithUniqueIdentifier(uniqueIdentifier, inTable: table)
            
            if indexOfObject != nil {
                table.removeAtIndex(indexOfObject!)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                completion?()
            })
        }
    }
    
    
    // MARK: Private class methods
    
    private class func getOrCreateTableForObjectWithType<ObjectClass where ObjectClass: Object>(objectType: ObjectClass.Type) -> [ObjectClass] {
        let objectClassName = NSStringFromClass(ObjectClass)
        
        var tableForSpecifiedClass: AnyObject? = tables[objectClassName]
        
        if tableForSpecifiedClass == nil {
            tableForSpecifiedClass = [ObjectClass]()
            tables[objectClassName] = tableForSpecifiedClass as! [ObjectClass]
        }
        
        return tableForSpecifiedClass as! [ObjectClass]
    }
    
    private class func indexOfObjectWithUniqueIdentifier<ObjectClass where ObjectClass: Object>(uniqueIdentifier: String, inTable table: [ObjectClass]) -> Int? {
        let numberOfObjectsInTable = table.count
        
        for i in 0..<numberOfObjectsInTable {
            let object = table[i]
            
            if object.uniqueIdentifier == uniqueIdentifier {
                return i
            }
        }
        
        return nil
    }
    
    private class func findObjectWithUniqueIdentifier<ObjectClass where ObjectClass: Object>(uniqueIdentifier: String, inTable table: [ObjectClass]) -> ObjectClass? {
        let numberOfObjectsInTable = table.count
        
        for i in 0..<numberOfObjectsInTable {
            let object = table[i]
            
            if object.uniqueIdentifier == uniqueIdentifier {
                return object
            }
        }
        
        return nil
    }
    
    
    // MARK: Initializers
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    
    // MARK: Public object methods
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
