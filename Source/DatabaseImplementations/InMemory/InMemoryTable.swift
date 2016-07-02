//
//  InMemoryTable.swift
//  DataKit
//
//  Created by Igor Matyushkin on 02.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class InMemoryTable<ObjectClass where ObjectClass: Object>: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    public override init() {
        super.init()
        
        
        // Initialize objects collection
        
        _objects = [ObjectClass]()
    }
    
    
    // MARK: Deinitializer
    
    deinit {
    }
    
    
    // MARK: Object variables & properties
    
    private var _objects: [ObjectClass]!
    
    private var objects: [ObjectClass] {
        get {
            return _objects
        }
    }
    
    
    // MARK: Public object methods
    
    public func insertObject(object: ObjectClass) {
        _objects.append(object)
    }
    
    public func findFirstSynchronouslyWithUniqueIdentifier(uniqueIdentifier: String) -> ObjectClass? {
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if object.uniqueIdentifier == uniqueIdentifier {
                return object
            }
        }
        
        return nil
    }
    
    public func findFirstAsynchronouslyWithUniqueIdentifier(uniqueIdentifier: String, andCompletion completion: (object: ObjectClass?) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let resultObject = self.findFirstSynchronouslyWithUniqueIdentifier(uniqueIdentifier)
            
            dispatch_async(dispatch_get_main_queue(), { 
                completion(object: resultObject)
            })
        }
    }
    
    public func findFirstOrCreateSynchronouslyWithUniqueIdentifier(uniqueIdentifier: String) -> ObjectClass {
        var resultObject: ObjectClass? = nil
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if object.uniqueIdentifier == uniqueIdentifier {
                resultObject = object
                break
            }
        }
        
        if resultObject == nil {
            resultObject = ObjectClass(uniqueIdentifier: uniqueIdentifier)
            _objects.append(resultObject!)
        }
        
        return resultObject!
    }
    
    public func findFirstOrCreateAsynchronouslyWithUniqueIdentifier(uniqueIdentifier: String, andCompletion completion: (object: ObjectClass) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let resultObject = self.findFirstOrCreateSynchronouslyWithUniqueIdentifier(uniqueIdentifier)
            
            dispatch_async(dispatch_get_main_queue(), {
                completion(object: resultObject)
            })
        }
    }
    
    public func deleteObjectWithUniqueIdentifier(uniqueIdentifier: String, andCompletion completion: (() -> Void)?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let indexOfObject = self.indexOfObjectWithUniqueIdentifier(uniqueIdentifier)
            
            if indexOfObject != nil {
                self._objects.removeAtIndex(indexOfObject!)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                completion?()
            })
        }
    }
    
    public func numberOfAllObjectsWithCompletion(completion: (numberOfObjects: Int) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let numberOfAllObjects = self.objects.count
            
            dispatch_async(dispatch_get_main_queue(), {
                completion(numberOfObjects: numberOfAllObjects)
            })
        }
    }
    
    public func numberOfObjectsSatisfyingRequirementsOfPredicate(predicate: ((object: ObjectClass) -> Bool), withCompletion completion: (numberOfObjects: Int) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let numberOfAllObjects = self.objects.count
            var resultNumberOfObjects = 0
            
            for i in 0..<numberOfAllObjects {
                let object = self.objects[i]
                let predicateBooleanResult = predicate(object: object)
                
                if predicateBooleanResult {
                    resultNumberOfObjects += 1
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                completion(numberOfObjects: resultNumberOfObjects)
            })
        }
    }
    
    public func selectObjectsWithBlockPredicate(predicate: ((object: ObjectClass) -> Bool), andCompletion completion: (objects: [ObjectClass]) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let numberOfAllObjects = self.objects.count
            var selectedObjects = [ObjectClass]()
            
            for i in 0..<numberOfAllObjects {
                let object = self.objects[i]
                let predicateBooleanResult = predicate(object: object)
                
                if predicateBooleanResult {
                    selectedObjects.append(object)
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                completion(objects: selectedObjects)
            })
        }
    }
    
    
    // MARK: Private object methods
    
    private func indexOfObjectWithUniqueIdentifier(uniqueIdentifier: String) -> Int? {
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if object.uniqueIdentifier == uniqueIdentifier {
                return i
            }
        }
        
        return nil
    }
    
    
    // MARK: Protocol methods
    
}
