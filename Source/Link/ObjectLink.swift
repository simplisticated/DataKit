//
//  ObjectLink.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import Foundation

internal class ObjectLink<ObjectClass where ObjectClass: NSObject>: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    public init(uniqueIdentifier: String) {
        super.init()
        
        
        // Initialize unique identifier
        
        _uniqueIdentifier = uniqueIdentifier
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    private var _uniqueIdentifier: String!
    
    public var uniqueIdentifier: String {
        get {
            return _uniqueIdentifier
        }
    }
    
    private var _cachedResult: ObjectClass?
    
    var cachedResult: ObjectClass? {
        get {
            return _cachedResult
        }
    }
    
    
    // MARK: Public object methods
    
    /**
    This method should be overriden in subclass.
    */
    public func loadObjectWithUniqueIdentifier(uniqueIdentifier: String, andCompletion completion: (object: ObjectClass?, error: Error?) -> Void) {
    }
    
    public final func loadObject(useCacheIfAvailable useCacheIfAvailable: Bool, completion: (object: ObjectClass?, error: Error?) -> Void) {
        if useCacheIfAvailable && (cachedResult != nil) {
            // Call completion block with cached result
            
            completion(object: cachedResult, error: nil)
        } else {
            loadObjectWithUniqueIdentifier(uniqueIdentifier, andCompletion: { (object, error) in
                // Update cached result
                
                self._cachedResult = object
                
                
                // Call completion block
                
                completion(object: object, error: error)
            })
        }
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}

