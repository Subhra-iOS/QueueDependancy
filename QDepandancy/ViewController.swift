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
    }

    private func startOperations(){
        let fetchOperation : FetchOperation = FetchOperation()
        let parseOperation : ParseOperation = ParseOperation()
        
        parseOperation.setCompletionCallback { [weak self] status in
            
            if status{
                print("\(String(describing: self?.operationQueue.operationCount))")
                print("\(String(describing: self?.operationQueue.operations))")
            }
            
        }
        
        
        let adapter = BlockOperation { [ unowned parseOperation ,  unowned fetchOperation] in
            print("Execute")
            parseOperation.setFetchDataWith(data: fetchOperation.dataFetched)
        }
        
        let completionBlock = BlockOperation {
            print("This is complete")
        }
        
        adapter.addDependency(fetchOperation)
        parseOperation.addDependency(adapter)
        
       /* completionBlock.addDependency(fetchOperation)
        completionBlock.addDependency(adapter)
        completionBlock.addDependency(parseOperation)*/
        
        operationQueue.addOperations([fetchOperation, adapter, parseOperation, completionBlock], waitUntilFinished: false)
        
        /*print("End1 == \(String(describing: self.operationQueue.operationCount))")
        print("End1 == \(String(describing: self.operationQueue.operations))")
        operationQueue.cancelAllOperations()
        print("End2 == \(String(describing: self.operationQueue.operationCount))")
        print("End2 == \(String(describing: self.operationQueue.operations))")*/
        
    }

}

