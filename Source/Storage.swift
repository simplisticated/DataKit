//
//  Storage.swift
//  DataKitDemo
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class Storage: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    public class func initializeStorage() {
    }
    
    public class func getOrCreateObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier uniqueIdentifier: String, andCompletion completion: ((object: ObjectClass) -> Void)?) {
    }
    
    public class func updateObject<ObjectClass where ObjectClass: Object>(object: ObjectClass, withCompletion completion: ((object: ObjectClass) -> Void)?) {
    }
    
    public class func deleteObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier uniqueIdentifier: String, andCompletion completion: (() -> Void)?) {
    }
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    
    // MARK: Public object methods
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
