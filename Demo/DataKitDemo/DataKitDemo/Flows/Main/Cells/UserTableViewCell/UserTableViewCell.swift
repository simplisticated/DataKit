//
//  UserTableViewCell.swift
//  DataKitDemo
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    class func reuseIdentifier() -> String {
        return "user-table-view-cell"
    }
    
    class func heightForUser(user: User?) -> CGFloat {
        return 80.0
    }
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Outlets
    
    @IBOutlet private weak var firstNameLabel: UILabel!
    
    @IBOutlet private weak var lastNameLabel: UILabel!
    
    @IBOutlet private weak var userIdLabel: UILabel!
    
    
    // MARK: Object variables & properties
    
    private var _userUniqueIdentifier: String?
    
    var userUniqueIdentifier: String? {
        get {
            return _userUniqueIdentifier
        }
        set {
            // Assertions for new value
            
            assert(newValue != nil, "User unique identifier should not be nil")
            
            
            // Update private variable
            
            _userUniqueIdentifier = newValue
            
            
            // Update first name label
            
            firstNameLabel.text = ""
            
            
            // Update last name label
            
            lastNameLabel.text = ""
            
            
            // Obtain user
            
            InMemoryStorage.getOrCreateObjectOfType(User.self, withUniqueIdentifier: newValue!) { (object) in
                // Update first name label
                
                self.firstNameLabel.text = object.firstName ?? ""
                
                
                // Update last name label
                
                self.lastNameLabel.text = object.lastName ?? ""
            }
        }
    }
    
    private var _user: User?
    
    private var user: User? {
        get {
            return _user
        }
        set {
            // Assertions for new value
            
            assert(newValue != nil, "User should not be nil")
            
            
            // Update private variable
            
            _user = newValue
            
            
            // Update first name label
            
            firstNameLabel.text = newValue!.firstName ?? ""
            
            
            // Update last name label
            
            lastNameLabel.text = newValue!.lastName ?? ""
        }
    }
    
    
    // MARK: Public object methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialize first name label
        
        firstNameLabel.text = ""
        
        
        // Initialize last name label
        
        lastNameLabel.text = ""
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Actions
    
    
    // MARK: Protocol methods
    
}
