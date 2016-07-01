//
//  ServiceLink.swift
//  DataKitDemo
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class ServiceLink<ServiceClass, ObjectClass where ServiceClass: Service, ObjectClass: Object>: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    public init(objectUniqueIdentifier: String) {
        super.init()
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    private var _objectUniqueIdentifier: String!
    
    public var objectUniqueIdentifier: String {
        get {
            return _objectUniqueIdentifier
        }
    }
    
    
    // MARK: Public object methods
    
    public func getObjectWithCompletion(completion: (object: ObjectClass?, error: NSError?) -> Void) {
        ServiceClass.getObjectOfType(ObjectClass.self, withUniqueIdentifier: objectUniqueIdentifier) { (object, error) in
            completion(object: object, error: error)
        }
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
