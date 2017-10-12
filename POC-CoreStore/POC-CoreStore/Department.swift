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
        self.name = source["department"] as? String
        self.number = 1
        self.designation = source["designation"] as? String
        self.sub = source["subDepartment"] as? String
//        employee?.department = self

    }
    
    
    public typealias ImportSource = [String: Any]
    
    @NSManaged public var designation: String?
    @NSManaged public var name: String?
    @NSManaged public var number: Int16
    @NSManaged public var sub: String?
    @NSManaged public var employee: Employee?
    

}
