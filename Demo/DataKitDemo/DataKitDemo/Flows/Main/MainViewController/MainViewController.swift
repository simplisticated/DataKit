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
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: Object variables & properties
    
    private var numberOfUsers = 0
    
    
    // MARK: Public object methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Initialize table view
        
        let nibForUserTableViewCell = UINib(nibName: "UserTableViewCell", bundle: nil)
        let reuseIdentifierForUserTableViewCell = UserTableViewCell.reuseIdentifier()
        tableView.registerNib(nibForUserTableViewCell, forCellReuseIdentifier: reuseIdentifierForUserTableViewCell)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Update number of users
        
        InMemoryStorage.defaultStorage().tableForObjectWithType(User.self).numberOfAllObjectsWithCompletion { (numberOfObjects) in
            self.numberOfUsers = numberOfObjects
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Private object methods
    
    
    // MARK: Actions
    
    
    // MARK: Protocol methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfUsers
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UserTableViewCell.reuseIdentifier()) as! UserTableViewCell
        
        let userUniqueIdentifier = String(format: "user-%d", indexPath.row)
        cell.userUniqueIdentifier = userUniqueIdentifier
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UserTableViewCell.heightForUser(nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
}
