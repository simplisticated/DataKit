//
//  BaseStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public protocol BaseStorage {
    
    func numberOfAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (_ numberOfObjects: Int) -> Void) -> Self
    
    func numberOfObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (_ object: ObjectClass) -> Bool, andCompletion completion: (_ numberOfObjects: Int) -> Void) -> Self
    
    func numberOfObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (_ numberOfObjects: Int) -> Void) -> Self
    
    func findAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (_ objects: [ObjectClass]) -> Void) -> Self
    
    func findAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (_ object: ObjectClass) -> Bool, andCompletion completion: (_ objects: [ObjectClass]) -> Void) -> Self
    
    func findAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (_ objects: [ObjectClass]) -> Void) -> Self
    
    func findFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (_ object: ObjectClass) -> Bool, andCompletion completion: (_ object: ObjectClass?) -> Void) -> Self
    
    func findFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (_ object: ObjectClass?) -> Void) -> Self
    
    func insertObject<ObjectClass: NSObject>(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self
    
    func updateObject<ObjectClass: NSObject>(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self
    
    func deleteAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self
    
    func deleteAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (_ object: ObjectClass) -> Bool, andCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self
    
    func deleteAllObjectsOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self
    
    func deleteFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (_ object: ObjectClass) -> Bool, andCompletion completion: ((_ deleted: Bool) -> Void)?) -> Self
    
    func deleteFirstObjectOfType<ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((_ deleted: Bool) -> Void)?) -> Self
    
    func clearStorageWithCompletion(completion: (() -> Void)?) -> Self
    
}

