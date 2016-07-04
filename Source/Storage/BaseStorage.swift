//
//  BaseStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

internal protocol BaseStorage {
    
    func numberOfAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (numberOfObjects: Int) -> Void) -> Self
    
    func numberOfObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (numberOfObjects: Int) -> Void) -> Self
    
    func numberOfObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (numberOfObjects: Int) -> Void) -> Self
    
    func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (objects: [ObjectClass]) -> Void) -> Self
    
    func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (objects: [ObjectClass]) -> Void) -> Self
    
    func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (objects: [ObjectClass]) -> Void) -> Self
    
    func findFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (object: ObjectClass?) -> Void) -> Self
    
    func findFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: (object: ObjectClass?) -> Void) -> Self
    
    func insertObject<ObjectClass where ObjectClass: NSObject>(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self
    
    func update<ObjectClass where ObjectClass: NSObject>(object object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self
    
    func deleteAllObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self
    
    func deleteAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self
    
    func deleteAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self
    
    func deleteFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((deleted: Bool) -> Void)?) -> Self
    
    func deleteFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, meetingCondition condition: String, andCompletion completion: ((deleted: Bool) -> Void)?) -> Self
    
    func clearStorageWithCompletion(completion: (() -> Void)?) -> Self
    
}

