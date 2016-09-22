//
//  InMemoryStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class InMemoryStorage: NSObject {
    
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
    
    public func tableForObjectWithType<ObjectClass: NSObject>(objectType: ObjectClass.Type) -> InMemoryTable<ObjectClass> {
        let objectClassName = NSStringFromClass(ObjectClass.self)
        
        var tableForSpecifiedClass = tables[objectClassName] as? InMemoryTable<ObjectClass>
        
        if tableForSpecifiedClass == nil {
            tableForSpecifiedClass = InMemoryTable<ObjectClass>()
            tables[objectClassName] = tableForSpecifiedClass
        }
        
        return tableForSpecifiedClass!
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
    @discardableResult
    public func numberOfAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: @escaping (_ numberOfObjects: Int) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.numberOfAllObjectsWithCompletion(completion: completion)
        return self
    }
    
    @discardableResult
    public func numberOfObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: @escaping (_ numberOfObjects: Int) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.numberOfObjectsWithPredicateBlock(predicateBlock: predicateBlock, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func numberOfObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: @escaping (_ numberOfObjects: Int) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.numberOfObjectsMeetingCondition(condition: condition, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func findAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: @escaping (_ objects: [ObjectClass]) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.findAllObjectsWithCompletion(completion: completion)
        return self
    }
    
    @discardableResult
    public func findAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: @escaping (_ objects: [ObjectClass]) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.findAllObjectsWithPredicateBlock(predicateBlock: predicateBlock, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func findAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: @escaping (_ objects: [ObjectClass]) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.findAllObjectsMeetingCondition(condition: condition, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func findFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: @escaping (_ object: ObjectClass?) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.findFirstObjectWithPredicateBlock(predicateBlock: predicateBlock, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func findFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: @escaping (_ object: ObjectClass?) -> Void) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.findFirstObjectMeetingCondition(condition: condition, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func insertObject<ObjectClass: NSObject>(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.insertObject(object: object, withCompletion: completion)
        return self
    }
    
    /**
    This method does nothing for in-memory storage
    since no special operation is required to save
    updated object.
    */
    @discardableResult
    public func updateObject<ObjectClass: NSObject>(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self {
        completion?()
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.deleteAllObjectsWithCompletion(completion: completion)
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.deleteAllObjectsWithPredicateBlock(predicateBlock: predicateBlock, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.deleteAllObjectsMeetingCondition(condition: condition, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func deleteFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: ((_ deleted: Bool) -> Void)?) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.deleteFirstObjectWithPredicateBlock(predicateBlock: predicateBlock, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func deleteFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((_ deleted: Bool) -> Void)?) -> Self {
        let table = tableForObjectWithType(objectType: ObjectClass.self)
        table.deleteFirstObjectMeetingCondition(condition: condition, andCompletion: completion)
        return self
    }
    
    @discardableResult
    public func clearStorageWithCompletion(completion: (() -> Void)?) -> Self {
        tables.removeAll(keepingCapacity: false)
        completion?()
        return self
    }
    
}
