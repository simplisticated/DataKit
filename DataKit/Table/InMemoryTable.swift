//
//  InMemoryTable.swift
//  DataKit
//
//  Created by Igor Matyushkin on 02.07.16.
//  Copyright © 2016 Igor Matyushkin. All rights reserved.
//

import UIKit

public class InMemoryTable<ObjectClass: NSObject>: NSObject {
    
    // MARK: Class variables & properties
    
    
    // MARK: Public class methods
    
    
    // MARK: Private class methods
    
    
    // MARK: Initializers
    
    public override init() {
        super.init()
        
        
        // Initialize objects collection
        
        _objects = [ObjectClass]()
        
        
        // Initialize operation queue
        
        //let nameForOperationQueue = String(format: "Operation queue for %@ table", NSStringFromClass(ObjectClass.self))
        //_operationQueue = DispatchQueue(label: nameForOperationQueue, qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        _operationQueue = DispatchQueue.global(qos: .background)
        
        
        // Initialize response queue
        
        _responseQueue = DispatchQueue.main
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
    
    private var _operationQueue: DispatchQueue!
    
    private var operationQueue: DispatchQueue {
        get {
            return _operationQueue
        }
    }
    
    private var _responseQueue: DispatchQueue!
    
    private var responseQueue: DispatchQueue {
        get {
            return _responseQueue
        }
    }
    
    
    // MARK: Public object methods
    
    @discardableResult
    public func numberOfAllObjectsWithCompletion(completion: @escaping (_ numberOfObjects: Int) -> Void) -> Self {
        runOnOperationQueue { 
            let numberOfObjects = self.objects.count
            
            self.runOnResponseQueue(block: {
                completion(numberOfObjects)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func numberOfAllObjectsSynchronously() -> Int {
        let numberOfObjects = self.objects.count
        return numberOfObjects
    }
    
    @discardableResult
    public func numberOfObjectsWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: @escaping (_ numberOfObjects: Int) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            var numberOfObjectsSatisfyingPredicate = 0
            let numberOfAllObjects = self.objects.count
            
            for i in 0..<numberOfAllObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object: object) {
                    numberOfObjectsSatisfyingPredicate += 1
                }
            }
            
            self.runOnResponseQueue(block: {
                completion(numberOfObjectsSatisfyingPredicate)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func numberOfObjectsSynchronouslyWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool) -> Int {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        var numberOfObjectsSatisfyingPredicate = 0
        let numberOfAllObjects = self.objects.count
        
        for i in 0..<numberOfAllObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object: object) {
                numberOfObjectsSatisfyingPredicate += 1
            }
        }
        
        return numberOfObjectsSatisfyingPredicate
    }
    
    @discardableResult
    public func numberOfObjectsMeetingCondition(condition: String, andCompletion completion: @escaping (_ numberOfObjects: Int) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            let objects = (self.objects as NSArray).filtered(using: predicate) as! [ObjectClass]
            let numberOfObjectsSatisfyingPredicate = objects.count
            
            self.runOnResponseQueue(block: {
                completion(numberOfObjectsSatisfyingPredicate)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func numberOfObjectsSynchronouslyMeetingCondition(condition: String) -> Int {
        let predicate = NSPredicate(format: condition)
        let objects = (self.objects as NSArray).filtered(using: predicate) as! [ObjectClass]
        let numberOfObjectsSatisfyingPredicate = objects.count
        return numberOfObjectsSatisfyingPredicate
    }
    
    @discardableResult
    public func findAllObjectsWithCompletion(completion: @escaping (_ objects: [ObjectClass]) -> Void) -> Self {
        runOnOperationQueue { 
            var allObjects = [ObjectClass]()
            allObjects.append(contentsOf: self.objects)
            
            self.runOnResponseQueue(block: { 
                completion(allObjects)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func findAllObjectsSynchronously() -> [ObjectClass] {
        var allObjects = [ObjectClass]()
        allObjects.append(contentsOf: self.objects)
        return allObjects
    }
    
    @discardableResult
    public func findAllObjectsWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: @escaping (_ objects: [ObjectClass]) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            var resultObjects = [ObjectClass]()
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object: object) {
                    resultObjects.append(object)
                }
            }
            
            self.runOnResponseQueue(block: { 
                completion(resultObjects)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func findAllObjectsSynchronouslyWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool) -> [ObjectClass] {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        var resultObjects = [ObjectClass]()
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object: object) {
                resultObjects.append(object)
            }
        }
        
        return resultObjects
    }
    
    @discardableResult
    public func findAllObjectsMeetingCondition(condition: String, andCompletion completion: @escaping (_ objects: [ObjectClass]) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            var resultObjects = [ObjectClass]()
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluate(with: object) {
                    resultObjects.append(object)
                }
            }
            
            self.runOnResponseQueue(block: {
                completion(resultObjects)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func findAllObjectsSynchronouslyMeetingCondition(condition: String) -> [ObjectClass] {
        let predicate = NSPredicate(format: condition)
        
        var resultObjects = [ObjectClass]()
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluate(with: object) {
                resultObjects.append(object)
            }
        }
        
        return resultObjects
    }
    
    @discardableResult
    public func findFirstObjectWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: @escaping (_ object: ObjectClass?) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluateWithObject(object: object) {
                    self.moveObjectFromIndex(currentIndex: i, toIndex: 0)
                    
                    self.runOnResponseQueue(block: {
                        completion(object)
                    })
                    
                    return
                }
            }
            
            self.runOnResponseQueue(block: {
                completion(nil)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func findFirstObjectSynchronouslyWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool) -> ObjectClass? {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object: object) {
                self.moveObjectFromIndex(currentIndex: i, toIndex: 0)
                return object
            }
        }
        
        return nil
    }
    
    @discardableResult
    public func findFirstObjectMeetingCondition(condition: String, andCompletion completion: @escaping (_ object: ObjectClass?) -> Void) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            let numberOfObjects = self.objects.count
            
            for i in 0..<numberOfObjects {
                let object = self.objects[i]
                
                if predicate.evaluate(with: object) {
                    self.moveObjectFromIndex(currentIndex: i, toIndex: 0)
                    
                    self.runOnResponseQueue(block: {
                        completion(object)
                    })
                    
                    return
                }
            }
            
            self.runOnResponseQueue(block: {
                completion(nil)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func findFirstObjectSynchronouslyMeetingCondition(condition: String) -> ObjectClass? {
        let predicate = NSPredicate(format: condition)
        
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluate(with: object) {
                self.moveObjectFromIndex(currentIndex: i, toIndex: 0)
                return object
            }
        }
        
        return nil
    }
    
    @discardableResult
    public func insertObject(object: ObjectClass, withCompletion completion: (() -> Void)?) -> Self {
        runOnOperationQueue {
            if self._objects.count == 0 {
                self._objects.append(object)
            } else {
                self._objects.insert(object, at: 0)
            }
            
            self.runOnResponseQueue(block: { 
                completion?()
            })
        }
        
        return self
    }
    
    @discardableResult
    public func insertObjectSynchronously(object: ObjectClass) -> Self {
        if self._objects.count == 0 {
            self._objects.append(object)
        } else {
            self._objects.insert(object, at: 0)
        }
        
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsWithCompletion(completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self {
        runOnOperationQueue {
            let numberOfObjectsToDelete = self.objects.count
            self._objects.removeAll(keepingCapacity: false)
            
            self.runOnResponseQueue(block: {
                completion?(numberOfObjectsToDelete)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsSynchronously() -> Self {
        self._objects.removeAll(keepingCapacity: false)
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingSelectionPredicate(predicate: predicate)
            let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
            
            for i in 0..<numberOfObjectsToDelete {
                let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
                self._objects.remove(at: indexOfCurrentObjectToDelete)
            }
            
            self.runOnResponseQueue(block: { 
                completion?(numberOfObjectsToDelete)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsSynchronouslyWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool) -> Self {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        
        let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingSelectionPredicate(predicate: predicate)
        let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
        
        for i in 0..<numberOfObjectsToDelete {
            let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
            self._objects.remove(at: indexOfCurrentObjectToDelete)
        }
        
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsMeetingCondition(condition: String, andCompletion completion: ((_ numberOfDeletedObjects: Int) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingNSPredicate(predicate: predicate)
            let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
            
            for i in 0..<numberOfObjectsToDelete {
                let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
                self._objects.remove(at: indexOfCurrentObjectToDelete)
            }
            
            self.runOnResponseQueue(block: {
                completion?(numberOfObjectsToDelete)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func deleteAllObjectsSynchronouslyMeetingCondition(condition: String) -> Self {
        let predicate = NSPredicate(format: condition)
        
        let indexesOfObjectsToDelete = self.indexesOfAllObjectsSatisfyingNSPredicate(predicate: predicate)
        let numberOfObjectsToDelete = indexesOfObjectsToDelete.count
        
        for i in 0..<numberOfObjectsToDelete {
            let indexOfCurrentObjectToDelete = indexesOfObjectsToDelete[i] - i
            self._objects.remove(at: indexOfCurrentObjectToDelete)
        }
        
        return self
    }
    
    @discardableResult
    public func deleteFirstObjectWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool, andCompletion completion: ((_ deleted: Bool) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
            
            let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingSelectionPredicate(predicate: predicate)
            
            var deleted = false
            
            if indexOfObjectToDelete != nil {
                self._objects.remove(at: indexOfObjectToDelete!)
                deleted = true
            }
            
            self.runOnResponseQueue(block: {
                completion?(deleted)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func deleteFirstObjectSynchronouslyWithPredicateBlock(predicateBlock: @escaping (_ object: ObjectClass) -> Bool) -> Self {
        let predicate = SelectionPredicate<ObjectClass>(block: predicateBlock)
        let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingSelectionPredicate(predicate: predicate)
        
        if indexOfObjectToDelete != nil {
            self._objects.remove(at: indexOfObjectToDelete!)
        }
        
        return self
    }
    
    @discardableResult
    public func deleteFirstObjectMeetingCondition(condition: String, andCompletion completion: ((_ deleted: Bool) -> Void)?) -> Self {
        runOnOperationQueue {
            let predicate = NSPredicate(format: condition)
            
            let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingNSPredicate(predicate: predicate)
            
            var deleted = false
            
            if indexOfObjectToDelete != nil {
                self._objects.remove(at: indexOfObjectToDelete!)
                deleted = true
            }
            
            self.runOnResponseQueue(block: {
                completion?(deleted)
            })
        }
        
        return self
    }
    
    @discardableResult
    public func deleteFirstObjectSynchronouslyMeetingCondition(condition: String) -> Self {
        let predicate = NSPredicate(format: condition)
        let indexOfObjectToDelete = self.indexOfFirstObjectSatisfyingNSPredicate(predicate: predicate)
        
        if indexOfObjectToDelete != nil {
            self._objects.remove(at: indexOfObjectToDelete!)
        }
        
        return self
    }
    
    
    // MARK: Private object methods
    
    private func indexesOfAllObjectsSatisfyingSelectionPredicate(predicate: SelectionPredicate<ObjectClass>) -> [Int] {
        var resultIndexes = [Int]()
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object: object) {
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
            
            if predicate.evaluate(with: object) {
                resultIndexes.append(i)
            }
        }
        
        return resultIndexes
    }
    
    private func indexOfFirstObjectSatisfyingSelectionPredicate(predicate: SelectionPredicate<ObjectClass>) -> Int? {
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluateWithObject(object: object) {
                return i
            }
        }
        
        return nil
    }
    
    private func indexOfFirstObjectSatisfyingNSPredicate(predicate: NSPredicate) -> Int? {
        let numberOfObjects = self.objects.count
        
        for i in 0..<numberOfObjects {
            let object = self.objects[i]
            
            if predicate.evaluate(with: object) {
                return i
            }
        }
        
        return nil
    }
    
    private func runOnOperationQueue(block: () -> Void) {
        operationQueue.sync {
            block()
        }
    }
    
    private func runOnResponseQueue(block: () -> Void) {
        responseQueue.sync {
            block()
        }
    }
    
    private func moveObjectFromIndex(currentIndex: Int, toIndex newIndex: Int) {
        let objectToMove = _objects[currentIndex]
        
        _objects.remove(at: currentIndex)
        
        if newIndex > _objects.count - 1 {
            _objects.append(objectToMove)
        } else {
            _objects.insert(objectToMove, at: newIndex)
        }
    }
    
    
    // MARK: Protocol methods
    
}
