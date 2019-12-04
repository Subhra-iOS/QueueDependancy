//
//  ParseOperation.swift
//  QDepandancy
//
//  Created by Subhra Roy on 04/12/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import Foundation

final class ParseOperation: AsyncOperation {

    private(set) var dataFetched: Data?

    func setFetchDataWith(data : Data?){
        self.dataFetched = data
    }
    
    override func execute(){
        super.execute()
        
        guard let responseData : Data = self.dataFetched else{
            self.finished()
            return
        }
        
        do{
            let response : Any = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print("\(response)")
            
        }catch{
            
        }
        
        sleep(2)
        self.finished()
    }
    
    deinit {
        print("ParseOperation dealloc")
    }
}

