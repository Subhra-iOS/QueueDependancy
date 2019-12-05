//
//  SRBlockOperation.swift
//  QDepandancy
//
//  Created by Subhra Roy on 05/12/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import Foundation

class SRBlockOperation : BlockOperation{
    
    override  func start() {
        super.start()
        print("Start Block Op")
    }

    override func cancel() {
        super.cancel()
        print("Cancel Block Op")
    }
    
    
    deinit {
        print("SRBlockOperation  dealloc")
    }
    
}
