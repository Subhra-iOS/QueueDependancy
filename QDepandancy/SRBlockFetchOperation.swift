//
//  SRBlockFetchOperation.swift
//  QDepandancy
//
//  Created by Subhra Roy on 05/12/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import Foundation

private typealias  BlockFetchCallBack = (_ data : Any?, _ status : Bool ) -> Void

final class SRBlockFetchOperation: AsyncOperation {

    private(set) var dataFetched: Data?
    
    private var fetchCompletionHandler : BlockFetchCallBack?

    private lazy var session = { () -> URLSession in
        let currentSession = URLSession(configuration: .default)
        return currentSession
    }()
    
    private var dataTask: URLSessionDataTask?
    
    convenience init( blockClosure : @escaping (_ data : Any?, _ status : Bool ) -> Void) {
        self.init()
        self.fetchCompletionHandler = blockClosure
    }
    
    private override init() {
        
    }

    override func execute(){
        super.execute()
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        dataTask = session.dataTask(with: url) { [weak self] (data, _, _) in
            guard let `self` = self else { return }
            // We could improve this fallback with a Result enum
            guard !self.isCancelled, let data = data else {
                self.finished()
                return
            }

            self.dataFetched = data
            print("Fetch Op End")
            self.fetchCompletionHandler?(self.dataFetched , true)
            //self.finished()
        }
        dataTask?.resume()
    }
    
    override func finished() {
        super.finished()
        session.finishTasksAndInvalidate()
    }
    
    override func cancel() {
        super.cancel()
    }
    
    deinit {
           print("FetchOperation dealloc")
    }
}
