//
//  SelectionPredicate.swift
//  DataKit
//
//  Created by Igor Matyushkin on 03.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class SelectionPredicate<ObjectClass where ObjectClass: NSObject>: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    init(block: (object: ObjectClass) -> Bool) {
        super.init()
        
        
        // Initialize predicate block
        
        predicateBlock = block
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    private var predicateBlock: ((object: ObjectClass) -> Bool)!
    
    
    // MARK: Public object methods
    
    func evaluateWithObject(object: ObjectClass) -> Bool {
        let result = predicateBlock(object: object)
        return result
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
