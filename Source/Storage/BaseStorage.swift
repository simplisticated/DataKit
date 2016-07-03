//
//  BaseStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

internal protocol BaseStorage {
    
    func numberOfAllObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withCompletion completion: (numberOfObjects: Int) -> Void)
    
    func numberOfObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withPredicate predicate: SelectionPredicate<ObjectClass>, andCompletion completion: (numberOfObjects: Int) -> Void)
    
    func findAllObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withCompletion completion: (objects: [ObjectClass]) -> Void)
    
    func findAllObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withPredicate predicate: SelectionPredicate<ObjectClass>, andCompletion completion: (objects: [ObjectClass]) -> Void)
    
    func findFirstObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withPredicate predicate: SelectionPredicate<ObjectClass>, andCompletion completion: (object: ObjectClass?) -> Void)
    
    func insertObject<ObjectClass where ObjectClass: Object>(object: ObjectClass, withCompletion completion: (() -> Void)?)
    
    func deleteAllObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?)
    
    func deleteAllObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withPredicate predicate: SelectionPredicate<ObjectClass>, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?)
    
    func deleteFirstObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass, withPredicate predicate: SelectionPredicate<ObjectClass>, andCompletion completion: ((deleted: Bool) -> Void)?)
    
}

