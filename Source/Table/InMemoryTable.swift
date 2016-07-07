//
//  InMemoryTable.swift
//  DataKit
//
//  Created by Igor Matyushkin on 02.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class InMemoryTable<ObjectClass where ObjectClass: NSObject>: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    public override init() {
        super.init()
        
        
        // Initialize objects collection
        
        _objects = [ObjectClass]()
        
        
        // Initialize operation queue
        
        let nameForOperationQueue = String(format: "Operation queue for %@ table", NSStringFromClass(ObjectClass))
        _operationQueue = dispatch_queue_create(nameForOperationQueue, DISPATCH_QUEUE_SERIAL)
        
        
        // Initialize response queue
        
        _responseQueue = dispatch_get_main_queue()
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
    
    private var _operationQueue: dispatch_queue_t!
    
    private var operationQueue: dispatch_queue_t {
        get {
            return _operationQueue
        }
    }
    
    private var _responseQueue: dispatch_queue_t!
    
    private var responseQueue: dispatch_queue_t {
        get {
            return _responseQueue
        }
    }
    
    
    // MARK: Public object methods
    
    public func numberOfAllObjectsWithCompletion(completion: (numberOfObjects: Int) -> Void) -> Self {
        runOnOperationQueue { 
            let numberOfObjects = self.objects.count
            
            self.runOnResponseQueue({ 
                completion(numberOfObjects: numberOfObjects)
            })
        }
        
        return self
    }
    
    public func numberOfAllObjectsSynchronously() -> Int {
        let numberOfObjects = self.objects.count
        return numberOfObjects
    }
    
    public func numberOfObjectsWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (numberOfObjects: Int) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            var numberOfObjectsSatisfyingPredicate = 0
            let numberOfAllObjects = self.objects.count
            
            for i in 0..<numberOfAllObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object) {
                    numberOfObjectsSatisfyingPredicate += 1
                }
            }
            
            self.runOnResponseQueue({
                completion(numberOfObjects: numberOfObjectsSatisfyingPredicate)
            })
        }
        
        return self
    }
    
    public func numberOfObjectsSynchronouslyWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool) -> Int {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        var numberOfObjectsSatisfyingPredicate = 0
        let numberOfAllObjects = self.objects.count
        
        for i in 0..<numberOfAllObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                numberOfObjectsSatisfyingPredicate += 1
            }
        }
        
        return numberOfObjectsSatisfyingPredicate
    }
    
    public func numberOfObjectsMeetingCondition(condition: String, andCompletion completion: (numberOfObjects: Int) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            let objects = (self.objects as NSArray).filteredArrayUsingPredicate(predicate) as! [ObjectClass]
            let numberOfObjectsSatisfyingPredicate = objects.count
            
            self.runOnResponseQueue({
                completion(numberOfObjects: numberOfObjectsSatisfyingPredicate)
            })
        }
        
        return self
    }
    
    public func numberOfObjectsSynchronouslyMeetingCondition(condition: String) -> Int {
        let predicate = NSPredicate(format: condition)
        let objects = (self.objects as NSArray).filteredArrayUsingPredicate(predicate) as! [ObjectClass]
        let numberOfObjectsSatisfyingPredicate = objects.count
        return numberOfObjectsSatisfyingPredicate
    }
    
    public func findAllObjectsWithCompletion(completion: (objects: [ObjectClass]) -> Void) -> Self {
        runOnOperationQueue { 
            var allObjects = [ObjectClass]()
            allObjects.appendContentsOf(self.objects)
            
            self.runOnResponseQueue({ 
                completion(objects: allObjects)
            })
        }
        
        return self
    }
    
    public func findAllObjectsSynchronously() -> [ObjectClass] {
        var allObjects = [ObjectClass]()
        allObjects.appendContentsOf(self.objects)
        return allObjects
    }
    
    public func findAllObjectsWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (objects: [ObjectClass]) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            var resultObjects = [ObjectClass]()
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object) {
                    resultObjects.append(object)
                }
            }
            
            self.runOnResponseQueue({ 
                completion(objects: resultObjects)
            })
        }
        
        return self
    }
    
    public func findAllObjectsSynchronouslyWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool) -> [ObjectClass] {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        var resultObjects = [ObjectClass]()
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                resultObjects.append(object)
            }
        }
        
        return resultObjects
    }
    
    public func findAllObjectsMeetingCondition(condition: String, andCompletion completion: (objects: [ObjectClass]) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            var resultObjects = [ObjectClass]()
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object) {
                    resultObjects.append(object)
                }
            }
            
            self.runOnResponseQueue({
                completion(objects: resultObjects)
            })
        }
        
        return self
    }
    
    public func findAllObjectsSynchronouslyMeetingCondition(condition: String) -> [ObjectClass] {
        let predicate = NSPredicate(format: condition)
        
        var resultObjects = [ObjectClass]()
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                resultObjects.append(object)
            }
        }
        
        return resultObjects
    }
    
    public func findFirstObjectWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: (object: ObjectClass?) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object) {
                    self.moveObjectFromIndex(i, toIndex: 0)
                    
                    self.runOnResponseQueue({
                        completion(object: object)
                    })
                    
                    return
                }
            }
            
            self.runOnResponseQueue({
                completion(object: nil)
            })
        }
        
        return self
    }
    
    public func findFirstObjectSynchronouslyWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool) -> ObjectClass? {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                self.moveObjectFromIndex(i, toIndex: 0)
                return object
            }
        }
        
        return nil
    }
    
    public func findFirstObjectMeetingCondition(condition: String, andCompletion completion: (object: ObjectClass?) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object) {
                    self.moveObjectFromIndex(i, toIndex: 0)
                    
                    self.runOnResponseQueue({
                        completion(object: object)
                    })
                    
                    return
                }
            }
            
            self.runOnResponseQueue({
                completion(object: nil)
            })
        }
        
        return self
    }
    
    public func findFirstObjectSynchronouslyMeetingCondition(condition: String) -> ObjectClass? {
        let predicate = NSPredicate(format: condition)
        
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                self.moveObjectFromIndex(i, toIndex: 0)
                return object
            }
        }
        
        return nil
    }
    
    public func insertObject(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self {
        runOnOperationQueue {
            if self._objects.count == 0 {
                self._objects.append(object)
            } else {
                self._objects.insert(object, atIndex: 0)
            }
            
            self.runOnResponseQueue({ 
                completion?()
            })
        }
        
        return self
    }
    
    public func insertObjectSynchronously(object: ObjectClass) -> Void {
        if self._objects.count == 0 {
            self._objects.append(object)
        } else {
            self._objects.insert(object, atIndex: 0)
        }
    }
    
    public func deleteAllObjectsWithCompletion(completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self {
        runOnOperationQueue {
            let numberOfObjectsToDelete = self.objects.count
            self._objects.removeAll(keepCapacity: false)
            
            self.runOnResponseQueue({
                completion?(numberOfDeletedObjects: numberOfObjectsToDelete)
            })
        }
        
        return self
    }
    
    public func deleteAllObjectsSynchronously() -> Void {
        self._objects.removeAll(keepCapacity: false)
    }
    
    public func deleteAllObjectsWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingSelectionPredicate(predicate)
            let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
            
            for i in 0..<numberOfObjectsToDelete {
                let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
                self._objects.removeAtIndex(indexOfCurrentObjectToDelete)
            }
            
            self.runOnResponseQueue({ 
                completion?(numberOfDeletedObjects: numberOfObjectsToDelete)
            })
        }
        
        return self
    }
    
    public func deleteAllObjectsSynchronouslyWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool) -> Void {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingSelectionPredicate(predicate)
        let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
        
        for i in 0..<numberOfObjectsToDelete {
            let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
            self._objects.removeAtIndex(indexOfCurrentObjectToDelete)
        }
    }
    
    public func deleteAllObjectsMeetingCondition(condition: String, andCompletion completion: ((numberOfDeletedObjects: Int) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingNSPredicate(predicate)
            let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
            
            for i in 0..<numberOfObjectsToDelete {
                let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
                self._objects.removeAtIndex(indexOfCurrentObjectToDelete)
            }
            
            self.runOnResponseQueue({
                completion?(numberOfDeletedObjects: numberOfObjectsToDelete)
            })
        }
        
        return self
    }
    
    public func deleteAllObjectsSynchronouslyMeetingCondition(condition: String) -> Void {
        let predicate = NSPredicate(format: condition)
        
        let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingNSPredicate(predicate)
        let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
        
        for i in 0..<numberOfObjectsToDelete {
            let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
            self._objects.removeAtIndex(indexOfCurrentObjectToDelete)
        }
    }
    
    public func deleteFirstObjectWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool, andCompletion completion: ((deleted: Bool) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingSelectionPredicate(predicate)
            
            var deleted = false
            
            if indexOfObjectToDelete != nil {
                self._objects.removeAtIndex(indexOfObjectToDelete!)
                deleted = true
            }
            
            self.runOnResponseQueue({
                completion?(deleted: deleted)
            })
        }
        
        return self
    }
    
    public func deleteFirstObjectSynchronouslyWithPredicateBlock(predicateBlock: (object: ObjectClass) -> Bool) -> Void {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingSelectionPredicate(predicate)
        
        if indexOfObjectToDelete != nil {
            self._objects.removeAtIndex(indexOfObjectToDelete!)
        }
    }
    
    public func deleteFirstObjectMeetingCondition(condition: String, andCompletion completion: ((deleted: Bool) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingNSPredicate(predicate)
            
            var deleted = false
            
            if indexOfObjectToDelete != nil {
                self._objects.removeAtIndex(indexOfObjectToDelete!)
                deleted = true
            }
            
            self.runOnResponseQueue({
                completion?(deleted: deleted)
            })
        }
        
        return self
    }
    
    public func deleteFirstObjectSynchronouslyMeetingCondition(condition: String) -> Void {
        let predicate = NSPredicate(format: condition)
        let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingNSPredicate(predicate)
        
        if indexOfObjectToDelete != nil {
            self._objects.removeAtIndex(indexOfObjectToDelete!)
        }
    }
    
    
    // MARK: Private object methods
    
    private func indexesOfAllObjectsSatisfyingSelectionPredicate(predicate: SelectionPredicate<ObjectClass>) -> [Int] {
        var resultIndexes = [Int]()
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                resultIndexes.append(i)
            }
        }
        
        return resultIndexes
    }
    
    private func indexesOfAllObjectsSatisfyingNSPredicate(predicate: NSPredicate) -> [Int] {
        var resultIndexes = [Int]()
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                resultIndexes.append(i)
            }
        }
        
        return resultIndexes
    }
    
    private func indexOfFirstObjectSatisfyingSelectionPredicate(predicate: SelectionPredicate<ObjectClass>) -> Int? {
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                return i
            }
        }
        
        return nil
    }
    
    private func indexOfFirstObjectSatisfyingNSPredicate(predicate: NSPredicate) -> Int? {
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object) {
                return i
            }
        }
        
        return nil
    }
    
    private func runOnOperationQueue(block: () -> Void) {
        dispatch_async(operationQueue) {
            block()
        }
    }
    
    private func runOnResponseQueue(block: () -> Void) {
        dispatch_async(responseQueue) {
            block()
        }
    }
    
    private func moveObjectFromIndex(currentIndex: Int, toIndex newIndex: Int) {
        let objectToMove = _objects[currentIndex]
        
        _objects.removeAtIndex(currentIndex)
        
        if newIndex > _objects.count - 1 {
            _objects.append(objectToMove)
        } else {
            _objects.insert(objectToMove, atIndex: newIndex)
        }
    }
    
    
    // MARK: Protocol methods
    
}
