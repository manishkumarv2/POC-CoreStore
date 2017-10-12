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
    var employee: Employee!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        print(employee)
        
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
        let bod = dateFormatter.string(from: employee.birthDate! as Date)
        
        details = "\(details) BirthDate : \(bod) \n"
        
        detailTextView.text = details
    }
}
