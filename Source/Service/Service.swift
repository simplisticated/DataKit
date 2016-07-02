//
//  Service.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class Service: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    public class func getObjectOfType<ObjectClass where ObjectClass: Object>(type: ObjectClass.Type, withUniqueIdentifier: String, andCompletion completion: ((object: ObjectClass?, error: Error?) -> Void)?) {
    }
    
    public class func createObject<ObjectClass where ObjectClass: Object>(object: ObjectClass, withCompletion completion: ((object: ObjectClass?, error: Error?) -> Void)?) {
    }
    
    public class func updateObject<ObjectClass where ObjectClass: Object>(object: ObjectClass, withCompletion completion: ((object: ObjectClass?, error: Error?) -> Void)?) {
    }
    
    public class func deleteObject<ObjectClass where ObjectClass: Object>(object: ObjectClass, withCompletion completion: ((error: Error?) -> Void)?) {
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
