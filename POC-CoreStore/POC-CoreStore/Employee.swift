//
//  Employee+CoreDataClass.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/11/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import CoreStore

@objc(Employee)
public class Employee: NSManagedObject, ImportableObject {
 
    /**
     Implements the actual importing of data from `source`. Implementers should pull values from `source` and assign them to the receiver's attributes. Note that throwing from this method will cause subsequent imports that are part of the same `importObjects(:sourceArray:)` call to be cancelled.
     
     - parameter source: the object to import from
     - parameter transaction: the transaction that invoked the import. Use the transaction to fetch or create related objects if needed.
     */
   public  func didInsert(from source: ImportSource, in transaction: BaseDataTransaction) throws {
        self.identity = source["id"] as? String
        self.firstName = source["fName"] as? String
        self.lastName = source["lName"] as? String
        self.gender = Int16((source["gender"] as? Int16)!)
        self.hireDate = NSDate()
        self.birthDate = source["bod"] as? NSDate
        self.empNo = Int16((source["empNumber"] as? Int16)!)
    
//    self.departure = transaction.importObject(Into(Station), source: source["departure"] as? [NSString: AnyObject]) // one-to-one
    
    self.department = try! transaction.importObject(Into<Department>(), source: source)
    self.salary = try! transaction.importObject(Into<Salary>(), source: source)
    
    }

    
    public typealias ImportSource = [String: Any]

    @NSManaged public var birthDate: NSDate?
    @NSManaged public var empNo: Int16
    @NSManaged public var firstName: String?
    @NSManaged public var gender: Int16
    @NSManaged public var hireDate: NSDate?
    @NSManaged public var identity: String?
    @NSManaged public var lastName: String?
    @NSManaged public var department: Department?
    @NSManaged public var salary: Salary?
    
    
}
