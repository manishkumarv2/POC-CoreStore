//
//  EmployeeListCell.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/11/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit

class EmployeeListCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var empID: UILabel!
    
    
    var employee: Employee! {
        didSet {
            updateDislayData()
        }
    }
    
    private func updateDislayData() {
        
        if let firstName = self.employee.firstName, let lastName = self.employee.lastName {
            name.text = "\(firstName) \(lastName)"
        }
        
        if let departmentName = self.employee.department?.name {
            self.department.text = departmentName
        }
        
//        if let employeeID = self.employee.empNo as? Int16 {
//            self.empID.text = "\(employeeID)"
//        }
        
        if let designation = self.employee.department?.designation {
            self.empID.text = designation
        }
        
        
    }
}
