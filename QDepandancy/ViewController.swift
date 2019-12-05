//
//  ViewController.swift
//  QDepandancy
//
//  Created by Subhra Roy on 04/12/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //private var blockOp : SRBlockOperation?
    
    private lazy var operationQueue : OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        return queue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.blockOp = SRBlockOperation()
        
       // startOperations()
       // startBlockOperation()
        startBlockExecuteOperation()
    }
    
        private func startBlockExecuteOperation(){
                
            let blockOp = SRBlockOperation()
                
            for i in  1 ..< 50 {
                let fetchOperation : SRBlockFetchOperation = SRBlockFetchOperation { (data, state) in
                      print("End of first Op\(i)")
                  }
                blockOp.addDependency(fetchOperation)
                self.operationQueue.addOperation(fetchOperation)
            }
               
            blockOp.completionBlock = { [weak  self] in
                print("End")
                print("Operation Object Array == \(String(describing: self?.operationQueue.operations))")
            }
                       
            self.operationQueue.addOperation(blockOp)

            DispatchQueue.global(qos: .default).asyncAfter(deadline: (.now() + 5.0)) { [weak self]  in
                //self?.operationQueue.cancelAllOperations()
                print("Operation Object Array at end == \(String(describing: self?.operationQueue.operations))")
               
            }
                
    }
    
    private func startBlockOperation(){
        
        let blockOp = SRBlockOperation()
        blockOp.addExecutionBlock { [/*weak blockOp ,*/ weak  self] in
            //print("Execute Block Op")
            let fetchOperation : FetchOperation = FetchOperation()
            self?.operationQueue.addOperation(fetchOperation)
          /*  for i in 0 ..< 1000 {
                if let operation = blockOp, operation.isCancelled {
                    print("Cancelled")
                     break
                }
                print(i)
            }*/
        }
        
        blockOp.completionBlock = {
            print("End")
        }
        
        blockOp.addExecutionBlock {  [/*weak blockOp ,*/ weak  self]   in
            
            let fetchOperation : FetchOperation = FetchOperation()
            self?.operationQueue.addOperation(fetchOperation)
           /* for i in 0 ..< 1000 {
                if let operation = blockOp, operation.isCancelled {
                    print("Cancelled")
                     break
                }
                print(i)
            }*/
        }
        
        self.operationQueue.addOperation(blockOp)
        
        
//        DispatchQueue.global(qos: .default).asyncAfter(deadline: (.now())) { [weak self]  in
//
//            self?.operationQueue.cancelAllOperations()
//
//        }
        
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

