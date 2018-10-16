//
//  AsyncOperation.swift
//  ScriptHelpers
//
//  Created by Kirby on 10/15/18.
//

import Foundation

open class AsyncOperation: Operation {
    public enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }
    
    public private(set) var state: State = .ready {
        willSet {
            if newValue != state {
                willChangeValue(forKey: State.ready.rawValue)
                willChangeValue(forKey: State.executing.rawValue)
                willChangeValue(forKey: State.finished.rawValue)
            }
        }
        
        didSet {
            if oldValue != state {
                didChangeValue(forKey: State.ready.rawValue)
                didChangeValue(forKey: State.finished.rawValue)
                didChangeValue(forKey: State.executing.rawValue)
            }
        }
    }
    
    open override var isAsynchronous: Bool {
        return true
    }
    
    open override var isReady: Bool {
        return state == .ready
    }
    
    open override var isExecuting: Bool {
        return state == .executing
    }
    
    open override var isFinished: Bool {
        return state == .finished
    }
    
    open override func cancel() {
        state = .finished
    }
    
    open override func start() {
        state = .executing
        execute()
    }
    
    open func execute() {
        fatalError("You must override this method")
    }
    
    open func finish() {
        state = .finished
    }
}

extension AsyncOperation {
    public func canExecute() -> Bool {
        return !isCancelled && !isFinished
    }
}
