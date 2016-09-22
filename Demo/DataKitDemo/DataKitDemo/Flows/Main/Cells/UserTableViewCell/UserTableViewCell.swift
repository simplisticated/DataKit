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
    
    class func heightForUser(_ user: User?) -> CGFloat {
        return 80.0
    }
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Outlets
    
    @IBOutlet fileprivate weak var firstNameLabel: UILabel!
    
    @IBOutlet fileprivate weak var lastNameLabel: UILabel!
    
    @IBOutlet fileprivate weak var userIdLabel: UILabel!
    
    
    // MARK: Object variables & properties
    
    fileprivate var _userUniqueIdentifier: String?
    
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
            
            let startTimestamp = Date().timeIntervalSince1970
            
            InMemoryStorage.defaultStorage().tableForObjectWithType(objectType: User.self).findFirstObjectWithPredicateBlock(predicateBlock: { (object) -> Bool in
                return object.uniqueIdentifier == newValue
                }) { (object) in
                    // Update first name label
                    
                    self.firstNameLabel.text = object?.firstName ?? ""
                    
                    
                    // Update last name label
                    
                    self.lastNameLabel.text = object?.lastName ?? ""
                    
                    
                    // Update user id label
                    
                    self.userIdLabel.text = object?.uniqueIdentifier ?? ""
                    
                    
                    // Report time interval
                    
                    let endTimestamp = Date().timeIntervalSince1970
                    let timeInterval = endTimestamp - startTimestamp
                    
                    NSLog("Selection finished in %f seconds", timeInterval)
            }
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Actions
    
    
    // MARK: Protocol methods
    
}
