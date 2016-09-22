//
//  MainViewController.swift
//  DataKitDemo
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Outlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    
    // MARK: Object variables & properties
    
    fileprivate var numberOfUsers = 0
    
    
    // MARK: Public object methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Initialize table view
        
        let nibForUserTableViewCell = UINib(nibName: "UserTableViewCell", bundle: nil)
        let reuseIdentifierForUserTableViewCell = UserTableViewCell.reuseIdentifier()
        tableView.register(nibForUserTableViewCell, forCellReuseIdentifier: reuseIdentifierForUserTableViewCell)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Update number of users
        
        InMemoryStorage.defaultStorage().numberOfAllObjectsOfType(type: User.self) { (numberOfObjects) in
            self.numberOfUsers = numberOfObjects
            self.tableView.reloadData()
        }.numberOfObjectsOfType(type: User.self, meetingCondition: "firstName == 'John", andCompletion: { (numberOfObjects) in
            NSLog("Number of users with name John = %d", numberOfObjects)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Actions
    
    
    // MARK: Protocol methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier()) as! UserTableViewCell
        
        let userUniqueIdentifier = String(format: "user-%d", (indexPath as NSIndexPath).row)
        cell.userUniqueIdentifier = userUniqueIdentifier
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserTableViewCell.heightForUser(nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
