//
//  EmpDetailViewController.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/4/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit

class EmpDetailViewController: UIViewController {
    
    
//    var employeeObjectMonitor = AppDataStack.dataStack.monitorObject(Employee)
    
    
    private var employee: Employee! {
        didSet{
            if detailTextView != nil {
                updateEmployee()
            }
        }
    }
    
    var employeeId: String = "" {
        didSet(id){
                fetchEmployeeByID()
            }
    }
    
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        print("ViewDIDLoad")
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
        details = "\(details) \(String(describing: employee.firstName!)) "
        details = "\(details) \(String(describing: employee.lastName!)) \n"
        let gender = employee.gender == 1 ? "Male" : "Female"
        details = "\(details) Gender : \(gender) \n"
        details = "\(details) Depatment : \(employee.department!.name!) \n"
        details = "\(details) Salary : \(String(describing: employee.salary!.amount)) \n"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        let dob = dateFormatter.string(from: employee.birthDate! as Date)
        
        details = "\(details) BirthDate : \(dob) \n"
        
        detailTextView.text = details
    }
    
    @IBAction func editThePerson(_ sender: Any) {
        AppDataStack.updateEmployee(identity: employeeId, lastName: "Kumar") { (result) in
            if result {
                self.clearAll()
                self.fetchEmployeeByID()
            }
        }
    }
    
    private func clearAll(){
        detailTextView.text = ""
    }
}
