//
//  Salary+CoreDataClass.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/11/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import CoreStore

@objc(Salary)
public class Salary: NSManagedObject, ImportableObject {
    
    public  func didInsert(from source: [String : Any], in transaction: BaseDataTransaction) throws {
        self.amount = Int16.max
//        employee?.salary = self
    }
    
    
    public typealias ImportSource = [String: Any]
    
    @NSManaged public var fromDate: NSDate?
    @NSManaged public var amount: Int16
    @NSManaged public var toDate: NSDate?
    @NSManaged public var employee: Employee?
}
