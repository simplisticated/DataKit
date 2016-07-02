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
        
        tables = [String : [Object]]()
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    private var tables: [String : AnyObject]!
    
    
    // MARK: Public object methods
    
    public func tableForObjectWithType<ObjectClass where ObjectClass: Object>(objectType: ObjectClass.Type) -> InMemoryTable<ObjectClass> {
        let objectClassName = NSStringFromClass(ObjectClass)
        
        var tableForSpecifiedClass = tables[objectClassName] as? InMemoryTable<ObjectClass>
        
        if tableForSpecifiedClass == nil {
            tableForSpecifiedClass = InMemoryTable<ObjectClass>()
            tables[objectClassName] = tableForSpecifiedClass
        }
        
        return tableForSpecifiedClass!
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
