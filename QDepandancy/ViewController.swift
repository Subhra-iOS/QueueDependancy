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
        
        let adapter = BlockOperation { [ unowned parseOperation ,  unowned fetchOperation] in
            parseOperation.setFetchDataWith(data: fetchOperation.dataFetched)
        }
        
        adapter.addDependency(fetchOperation)
        parseOperation.addDependency(adapter)
        
        operationQueue.addOperations([fetchOperation, adapter, parseOperation], waitUntilFinished: true)
        
    }

}

