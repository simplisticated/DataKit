//
//  BaseStorage.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public protocol BaseStorage {
    
    func initializeStorage()
    
    func getObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier uniqueIdentifier: String, andCompletion completion: (object: ObjectClass?) -> Void)
    
    func getOrCreateObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier uniqueIdentifier: String, andCompletion completion: ((object: ObjectClass) -> Void)?)
    
    func updateObject<ObjectClass where ObjectClass: Object>(object: ObjectClass, withCompletion completion: ((object: ObjectClass) -> Void)?)
    
    func deleteObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier uniqueIdentifier: String, andCompletion completion: (() -> Void)?)
    
    func numberOfAllObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withCompletion completion: (numberOfObjects: Int) -> Void)
    
    func numberOfObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, satisfyingRequirementsOfPredicate predicate: ((object: ObjectClass) -> Bool), withCompletion completion: (numberOfObjects: Int) -> Void)
    
    func selectObjectsOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withBlockPredicate predicate: ((object: ObjectClass) -> Bool), andCompletion completion: (objects: [ObjectClass]) -> Void)
    
}

