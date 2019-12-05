//
//  ViewController.swift
//  QDepandancy
//
//  Created by Subhra Roy on 04/12/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var operationQueue : OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        return queue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startOperations()
        //startBlockOperation()
    }
    
    private func startBlockOperation(){
        
        let blockOp = SRBlockOperation()
        blockOp.addExecutionBlock {
            print("Execute Block Op")
        }
            
        self.operationQueue.addOperation(blockOp)
        self.operationQueue.cancelAllOperations()
        
    }

    private func startOperations(){
//        let fetchOperation1 : FetchOperation = FetchOperation()
//        let fetchOperation2 : FetchOperation = FetchOperation()
//        let fetchOperation3 : FetchOperation = FetchOperation()
//        let fetchOperation4 : FetchOperation = FetchOperation()
        
        let fetchOperation : FetchOperation = FetchOperation()
        let parseOperation : ParseOperation = ParseOperation()
        
        parseOperation.setCompletionCallback { [weak self] status in
            if status{
                print("\(String(describing: self?.operationQueue.operationCount))")
                print("\(String(describing: self?.operationQueue.operations))")
            }
        }
        
        let adapter = SRBlockOperation { [ unowned parseOperation ,  unowned fetchOperation] in
            print("Execute")
            parseOperation.setFetchDataWith(data: fetchOperation.dataFetched)
        }
                
//        let completionBlock = BlockOperation {
//            print("This is complete")
//        }
//
//        completionBlock.addExecutionBlock({ [unowned completionBlock] in
//            for i in 0 ..< 10000 {
//                if completionBlock.isCancelled {
//                    print("Cancelled")
//                     break
//                }
//                print(i)
//            }
//        })
        
        adapter.addDependency(fetchOperation)
        parseOperation.addDependency(adapter)
        
//        completionBlock.addDependency(fetchOperation1)
//        completionBlock.addDependency(fetchOperation2)
//        completionBlock.addDependency(fetchOperation3)
//        completionBlock.addDependency(fetchOperation4)
//
        
        operationQueue.addOperations([fetchOperation, adapter, parseOperation], waitUntilFinished: false)
       // operationQueue.addOperations([fetchOperation1, fetchOperation2, fetchOperation3, fetchOperation4], waitUntilFinished: false)
        
//        print("End1 == \(String(describing: self.operationQueue.operationCount))")
//        print("End1 == \(String(describing: self.operationQueue.operations))")
//        operationQueue.cancelAllOperations()
//        print("End2 == \(String(describing: self.operationQueue.operationCount))")
//        print("End2 == \(String(describing: self.operationQueue.operations))")
//        print("End2*1 == \(String(describing: self.operationQueue.operationCount))")
        
//        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now()) { [weak  self]  in
//            
//            print("End1 == \(String(describing: self?.operationQueue.operationCount))")
//            print("End1 == \(String(describing: self?.operationQueue.operations))")
//            self?.operationQueue.cancelAllOperations()
//           print("End2 == \(String(describing: self?.operationQueue.operationCount))")
//           print("End2 == \(String(describing: self?.operationQueue.operations))")
//           print("End2*1 == \(String(describing: self?.operationQueue.operationCount))")
//            
//        }
        
    }

}

