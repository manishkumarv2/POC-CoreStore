//
//  EmpDetailViewController.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/4/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit
import CoreStore

class EmpDetailViewController: UIViewController, ObjectObserver {
    
    
    var employee: Employee? {
        
        get {
            
            return self.monitor?.object
        }
        set {
            
            guard self.monitor?.object != newValue else {
                
                return
            }
            
            if let employee = newValue {
                
                self.monitor = AppDataStack.sharedInstance.monitorObject(employee)
            }
            else {
                
                self.monitor = nil
            }
        }
    }
    
    // MARK: NSObject
    
    deinit {
        
        self.monitor?.removeObserver(self)
    }
    
    var monitor: ObjectMonitor<Employee>?
    
//    private var employee: Employee! {
//        didSet{
//            if detailTextView != nil {
//                updateEmployee()
//            }
//        }
//    }
    
    var employeeId: String = "" {
        didSet(id){
                fetchEmployeeByID()
            }
    }
    
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        print("viewDidLoad \(self)")
        self.monitor?.addObserver(self)
    }

    // MARK: ObjectObserver
    
    func objectMonitor(_ monitor: ObjectMonitor<Employee>, didUpdateObject object: Employee, changedPersistentKeys: Set<KeyPath>) {
        
        print(changedPersistentKeys)
        updateEmployee()
    }
    
    func objectMonitor(_ monitor: ObjectMonitor<Employee>, didDeleteObject object: Employee) {
        print("\(object)")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        updateEmployee()
    }
    
    private func fetchEmployeeByID(){
        AppDataStack.fetchEmployee(identity: employeeId, completion: { (emp) in
            if let emp = emp {
                employee = emp
            }
        })
    }
    
    func updateEmployee(){
        var details: String = "Name : "
        if let firstName = employee?.firstName{
            details = "\(details) \(String(describing: firstName)) "
        }
        if let lastName = employee?.lastName{
            details = "\(details) \(String(describing: lastName)) \n"
        }
        let gender = employee?.gender == 1 ? "Male" : "Female"
        details = "\(details) Gender : \(gender) \n"
        
        if let department = employee?.department{
                if let name = department.name{
                    details = "\(details) Depatment : \(String(describing: name)) \n"
            }
        }
        if let salary = employee?.salary{
            details = "\(details) Salary : \(String(describing: salary.amount)) \n"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        if let birthDate = employee?.birthDate {
            let dob = dateFormatter.string(from: birthDate as Date)
            details = "\(details) BirthDate : \(dob) \n"
        }
        detailTextView.text = details
        detailTextView.backgroundColor = UIColor.red
        detailTextView.tintColor = UIColor.green
        print(detailTextView.text)
    }
    
    @IBAction func editThePerson(_ sender: Any) {
        
        let lastName = ((employee?.gender != 0) ? "Sir" : "Madam")
        AppDataStack.updateEmployee(identity: employeeId, lastName: lastName) { (result) in
            if result {
                // No Need to call These when you use ObjectObserver
                // It was usefull when you are not Ussing ObjectObserver
//                self.clearAll()
//                self.fetchEmployeeByID()
            }
        }
    }
    
    private func clearAll(){
        detailTextView.text = ""
    }
}
