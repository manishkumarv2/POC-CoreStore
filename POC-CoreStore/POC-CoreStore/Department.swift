//
//  Department+CoreDataClass.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/11/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import CoreStore

@objc(Department)
public class Department: NSManagedObject, ImportableObject {
    
    public  func didInsert(from source: [String : Any], in transaction: BaseDataTransaction) throws {
        
        if let source = source["department"] as? [String:Any] {
            self.name = source["name"] as? String
            self.number = Int16(Int((source["id"] as? Int)!))
            self.designation = source["designation"] as? String
            self.sub = source["sub"] as? String
    //        employee?.department = self
        }
    }
    
    
    public typealias ImportSource = [String: Any]


}

extension Department{
    @NSManaged public var designation: String?
    @NSManaged public var name: String?
    @NSManaged public var number: Int16
    @NSManaged public var sub: String?
    @NSManaged public var employee: Employee?
}
