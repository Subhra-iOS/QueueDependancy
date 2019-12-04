
//
//  FetchOperation.swift
//  QDepandancy
//
//  Created by Subhra Roy on 04/12/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import Foundation

final class FetchOperation: AsyncOperation {

    private(set) var dataFetched: Data?

    private lazy var session = { () -> URLSession in
        let currentSession = URLSession(configuration: .default)
        return currentSession
    }()
    
    private var dataTask: URLSessionDataTask?

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
            self.finished()
        }
        dataTask?.resume()
    }
    
    override func finished() {
        super.finished()
        session.finishTasksAndInvalidate()
    }
    
    deinit {
           print("FetchOperation dealloc")
    }
}
