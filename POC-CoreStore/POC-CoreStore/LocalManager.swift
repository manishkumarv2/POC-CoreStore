//
//  LocalManager.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 10/18/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import CoreStore

class LocalManager {
    
    static func jsonFetcher(name: String) -> Void {
   
        if let path = Bundle.main.path(forResource: "employee", ofType: "json")
        {
            do{
                let jsonData = try NSData(contentsOfFile: path, options: .uncached)
                if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    if let employees : NSArray = jsonResult["employees"] as? NSArray
                    {
                        AppDataStack.dataStack.perform(
                            asynchronous: { (transaction) -> Void in
                                let jsonArray: [[String: Any]] = employees as! [[String : Any]]
                                for json in jsonArray {
                                   _ = try! transaction.importUniqueObject(
                                        Into<Employee>(),
                                        source: json
                                    )
                                }
                        },
                            completion: { _ in }
                        )
                    }
                }
            } catch(let catched){
                print(catched)
            }
            
        }
    }
}
