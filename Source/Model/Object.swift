//
//  Object.swift
//  DataKit
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class Object: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    public required override init() {
        super.init()
    }
    
    public required init(uniqueIdentifier: String) {
        super.init()
        
        
        // Initialize unique identifier
        
        self.uniqueIdentifier = uniqueIdentifier
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    public var uniqueIdentifier: String?
    
    
    // MARK: Public object methods
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
