//
//  AppDataStack.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/3/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import CoreStore

class AppDataStack {
    
    static let dataStack = DataStack(xcodeModelName: "POC-CoreStore") // keep reference to the stack
    
    static func CreateCoreStore() {
        
        let sqLiteStore = SQLiteStore(fileName: "POC-CoreStore.sqlite",
                                      localStorageOptions: .allowSynchronousLightweightMigration)
        print(sqLiteStore.fileURL)
        
        do {
            try AppDataStack.dataStack.addStorageAndWait(sqLiteStore)
        }
        catch { // ...
            print("CreateCoreStore() error")
        }
        
    }

    
    static func createEmployee(person: [String:Any]) {
        
        AppDataStack.dataStack.perform(
            asynchronous: { (transaction) -> Void in
                let json: [String: Any] = person
                   _ = try! transaction.importObject(
                        Into<Employee>(),
                        source: json
                )
                
        },
            completion: { emp in
                print(emp)
        }
        )
        
        
        
        /*
        AppDataStack.dataStack.perform(asynchronous: { (transaction) -> Void in
            let employee = transaction.create(Into<Employee>())
            employee.identity = person["id"] as? String
            employee.firstName = person["fName"] as? String
            employee.lastName = person["lName"] as? String
            employee.gender = Int16((person["gender"] as? Int16)!)
            employee.hireDate = NSDate()
            employee.birthDate = person["bod"] as? NSDate
            employee.empNo = Int16((person["empNumber"] as? Int16)!)
            
            
            let department = transaction.create(Into<Department>())
            department.name = person["department"] as? String
            department.number = 1
            department.designation = person["designation"] as? String
            department.sub = person["subDepartment"] as? String
            employee.department = department
            
            
            let salary = transaction.create(Into<Salary>())
            salary.amount = Int16.max
            employee.salary = salary
            
        }) { (s) in
            print(s)
        }
        */
    }
    
    static func fetchAllEmployee() -> [Employee] {
        if let people: [Employee] = AppDataStack.dataStack.fetchAll(
                From(Employee.self),
                OrderBy(.ascending("empNo"))
            ) {
            return people
        }
        return []
    }
    
    
    static func fetchEmployee(whereClouse: String) -> [Employee] {
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "department.designation", ascending: true)
        print(whereClouse)
        let employee = dataStack.fetchAll(
            From<Employee>(),
            Where(whereClouse),
//            OrderBy(.ascending("firstName"))
            OrderBy(descriptor)
            ) ?? []
        return employee
        
    }
    
    static func fetchEmployee(predicate: NSPredicate) -> [Employee] {
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
//        let predicate = NSPredicate(format: "ANY department.sub == %@", "iOS")
        
        
        let employee = dataStack.fetchAll(
            From<Employee>(),
            Where(predicate),
            //            OrderBy(.ascending("firstName"))
            OrderBy(descriptor)
            ) ?? []
        return employee
        
    }
    
    static func fetchEmployee(whereClouse: String , whereClouse2: String) -> [Employee] {
        

        let employee = dataStack.fetchAll(
            From<Employee>(),
            Where(whereClouse) && Where(whereClouse2),
            OrderBy(.ascending("firstName"))
            ) ?? []
        return employee
    }
    
//    static func deleteEmployee(employee: Employee) {
//        AppDataStack.dataStack.perform(asynchronous: { (transaction) -> Void in
//            transaction.delete(employee)
//        }, success: { (success) in
//            print(success)
//        }) { (csError) in
//            print(csError)
//        }
//    }
    
   
    static func deleteEmployee(employee: Employee) {
        AppDataStack.dataStack.perform(
            asynchronous: { (transaction) -> Bool in
                transaction.delete(employee)
                return transaction.hasChanges
        },completion: { (result) -> Void in
            switch result {
            case .success(let hasChanges): print("success! Has changes? \(hasChanges)")
            case .failure(let error): print(error)
            }
        })
    }
    
    
    static func deleteEmployee(employee: Employee, completion:@escaping (Bool,Error?) -> Void) {
        AppDataStack.dataStack.perform(
            asynchronous: { (transaction) -> Bool in
                transaction.delete(employee)
                return transaction.hasChanges
        },completion: { (result) -> Void in
            switch result {
            case .success(let hasChanges):
                print("success! Has changes? \(hasChanges)")
                completion(hasChanges,nil)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
        })
    }
 
    
    
}