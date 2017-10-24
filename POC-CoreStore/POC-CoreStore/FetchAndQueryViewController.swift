//
//  FetchAndQueryViewController.swift
//  POC-CoreStore
//
//  Created by aanchal on 23/10/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit
import CoreStore

class FetchAndQueryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var employeeTableView: UITableView!
    
    
    var employeeList: [(title: String, detail: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func queryButtonTapped(_ sender: UIBarButtonItem) {        
//        employeeList = AppDataStack.fetchEmployeeWithSelect()
        let employeeList = AppDataStack.dataStack.queryAttributes(
            From<Employee>(),
            Select<NSDictionary>(.count(#keyPath(Employee.gender)), #keyPath(Employee.gender)),
            GroupBy(#keyPath(Employee.gender))
//            OrderBy(.ascending(#keyPath(Employee.gender)))
        )
        print(employeeList as Any)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "empCell") as! EmployeeListCell
        return cell
        
    }

}
