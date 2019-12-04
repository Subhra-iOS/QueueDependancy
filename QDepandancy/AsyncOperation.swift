
//
//  AsyncOperation.swift
//  QDepandancy
//
//  Created by Subhra Roy on 04/12/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    enum State: String {
        case isReady, isExecuting, isFinished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
   private var state = State.isReady {
        willSet {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isExecuting: Bool {
        return state == .isExecuting
    }
    
    override var isFinished: Bool {
        return state == .isFinished
    }
    
    override final func start() {
        guard !self.isCancelled else {
            state = .isFinished
            return
        }
        state = .isExecuting
        main()
    }
    
    override final func main() {
           execute()
    }
    
    open func execute(){
        print("Subclass must override it.")
    }
    
    open func finished(){
        state = .isFinished
    }
    
}
