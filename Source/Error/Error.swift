//
//  Error.swift
//  DataKit
//
//  Created by Igor Matyushkin on 02.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class Error: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    public init(error: NSError, errorTitle: String, errorDescription: String) {
        super.init()
        
        
        // Initialize error
        
        _error = error
        
        
        // Initialize error title
        
        _errorTitle = errorTitle
        
        
        // Initialize error description
        
        _errorDescription = errorDescription
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    private var _error: NSError!
    
    public var error: NSError {
        get {
            return _error
        }
    }
    
    private var _errorTitle: String!
    
    public var errorTitle: String {
        get {
            return _errorTitle
        }
    }
    
    private var _errorDescription: String!
    
    public var errorDescription: String {
        get {
            return _errorDescription
        }
    }
    
    
    // MARK: Public object methods
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
}
