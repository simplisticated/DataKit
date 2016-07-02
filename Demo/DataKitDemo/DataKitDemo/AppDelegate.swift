//
//  AppDelegate.swift
//  DataKitDemo
//
//  Created by Igor Matyushkin on 01.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    var window: UIWindow?
    
    
    // MARK: Public object methods
    
    
    // MARK: Private object methods
    
    
    // MARK: Protocol methods
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Create window
        
        let frameForWindow = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frameForWindow)
        window!.backgroundColor = .whiteColor()
        window!.makeKeyAndVisible()
        
        
        // Switch to waiting flow
        
        let waitingViewController = WaitingViewController(nibName: "WaitingViewController", bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: waitingViewController)
        
        window!.rootViewController = navigationController
        
        
        
        // Fill database
        
        let startTimestamp = NSDate().timeIntervalSince1970
        
        let dispatchGroup = dispatch_group_create()
        
        dispatch_group_enter(dispatchGroup)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            for i in 0..<2000 {
                let uniqueIdentifier = String(format: "user-%d", i)
                
                let user = InMemoryStorage.defaultStorage().tableForObjectWithType(User.self).findFirstOrCreateSynchronouslyWithUniqueIdentifier(uniqueIdentifier)
                
                if i % 2 == 0 {
                    user.firstName = "John"
                    user.lastName = "Appleseed"
                } else {
                    user.firstName = "Barack"
                    user.lastName = "Obama"
                }
            }
            
            dispatch_group_leave(dispatchGroup)
        }
        
        dispatch_group_notify(dispatchGroup, dispatch_get_main_queue()) {
            let endTimestamp = NSDate().timeIntervalSince1970
            let timeResult = endTimestamp - startTimestamp
            NSLog("Filled database in %.3f seconds", timeResult)
            
            InMemoryStorage.defaultStorage().tableForObjectWithType(User.self).numberOfAllObjectsWithCompletion({ (numberOfObjects) in
                NSLog("Number of all objects: %d", numberOfObjects)
            })
            
            
            // Switch to main flow
            
            let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
            
            let navigationController = UINavigationController(rootViewController: mainViewController)
            
            self.window!.rootViewController = navigationController
        }
        
        
        // Return result
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

