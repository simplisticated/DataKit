//
//  BaseStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

internal protocol BaseStorage {
    
    func numberOfAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (numberOfObjects: Int) -> Void)
    
    func numberOfObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (numberOfObjects: Int) -> Void)
    
    func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: (objects: [ObjectClass]) -> Void)
    
    func findAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (objects: [ObjectClass]) -> Void)
    
    func findFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (object: ObjectClass?) -> Void)
    
    func insertObject<ObjectClass where ObjectClass: NSObject>(object: ObjectClass, withCompletion completion: (() -> Void)?)
    
    func deleteAllObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?)
    
    func deleteAllObjectsOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?)
    
    func deleteFirstObjectOfType<ObjectClass where ObjectClass: NSObject>(type: ObjectClass.Type, withPredicateBlock predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((deleted: Bool) -> Void)?)
    
}

