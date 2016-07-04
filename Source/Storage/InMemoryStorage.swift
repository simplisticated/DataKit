//
//  InMemoryStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class InMemoryStorage: NSObject, BaseStorage {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    public class func defaultStorage() -> InMemoryStorage {
        struct Singleton {
            static let storage = InMemoryStorage()
        }
        
        return Singleton.storage
    }
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
        
        
        // Initialize tables collection
        
        tables = [String : AnyObject]()
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    private var tables: [String : AnyObject]!
    
    
    // MARK: Public object methods
    
    public func numberOfAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (numberOfObjects: Int) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.numberOfAllObjectsWithCompletion(completion)
        return self
    }
    
    public func numberOfObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (numberOfObjects: Int) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.numberOfObjectsWithPredicateBlock(predicateBlock, andCompletion: completion)
        return self
    }
    
    public func numberOfObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (numberOfObjects: Int) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.numberOfObjectsMeetingCondition(condition, andCompletion: completion)
        return self
    }
    
    public func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (objects: [ObjectClass]) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.findAllObjectsWithCompletion(completion)
        return self
    }
    
    public func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (objects: [ObjectClass]) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.findAllObjectsWithPredicateBlock(predicateBlock, andCompletion: completion)
        return self
    }
    
    public func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (objects: [ObjectClass]) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.findAllObjectsMeetingCondition(condition, andCompletion: completion)
        return self
    }
    
    public func findFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (object: ObjectClass?) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.findFirstObjectWithPredicateBlock(predicateBlock, andCompletion: completion)
        return self
    }
    
    public func findFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (object: ObjectClass?) -> Void) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.findFirstObjectMeetingCondition(condition, andCompletion: completion)
        return self
    }
    
    public func insertObject<ObjectClass where ObjectClass: NSObject>(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.insertObject(object, withCompletion: completion)
        return self
    }
    
    /**
    This method does nothing for in-memory storage
    since no special operation is required to save
    updated object.
    */
    public func update<ObjectClass where ObjectClass: NSObject>(object object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self {
        return self
    }
    
    public func deleteAllObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.deleteAllObjectWithCompletion(completion)
        return self
    }
    
    public func deleteAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.deleteAllObjectsWithPredicateBlock(predicateBlock, andCompletion: completion)
        return self
    }
    
    public func deleteAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.deleteAllObjectsMeetingCondition(condition, andCompletion: completion)
        return self
    }
    
    public func deleteFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((deleted: Bool) -> Void)?) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.deleteFirstObjectWithPredicateBlock(predicateBlock, andCompletion: completion)
        return self
    }
    
    public func deleteFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((deleted: Bool) -> Void)?) -> Self {
        let table = tableForObjectWithType(ObjectClass)
        table.deleteFirstObjectMeetingCondition(condition, andCompletion: completion)
        return self
    }
    
    public func clearStorageWithCompletion(completion: (() -> Void)?) -> Self {
        tables.removeAll(keepCapacity: false)
        completion?()
        return self
    }
    
    public func tableForObjectWithType<ObjectClass where ObjectClass: NSObject>(objectType: ObjectClass.Type) -> InMemoryTable<ObjectClass> {
        let objectClassName = NSStringFromClass(ObjectClass)
        
        var tableForSpecifiedClass = tables[objectClassName] as? InMemoryTable<ObjectClass>
        
        if tableForSpecifiedClass == nil {
            tableForSpecifiedClass = InMemoryTable<ObjectClass>()
            tables[objectClassName] = tableForSpecifiedClass
        }
        
        return tableForSpecifiedClass!
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
