//
//  EmployeeListViewController.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/3/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit
import CoreStore

class EmployeeListViewController: UIViewController {
    
    
    let filterDepartments: [String] = ["Mobile","Web","Contant","Server","HR","Admin"]
    let filterSubDepartments: [String] = ["iOS","Android","Bussiness","Managment","Testing"]
    let filterDesignations: [String] = ["ASE","SE","SSE","TL","STL","BA","PM","QA"]
    
    var selectedDepartment = ""
    var selectedSubDepartment = ""
    var selectedDesignation = ""
    
    var selectedDepartmentRow = 0
    var selectedSubDepartmentRow = 0
    var selectedDesignationRow = 0
    
    var pickerViewTextField: UITextField = UITextField(frame: CGRect(x: 0.0,y:0.0, width: UIScreen.main.bounds.width, height: 1.0))
    
    @IBOutlet weak var employeeTableView: UITableView!
    
    
    var person: Employee = Employee()
    
    
    var employeeList: [Employee]! = [] {
        didSet {
//            person = employeeList[0]
//            self.monitor = CoreStore.monitorObject(person)
//            self.monitor.addObserver(self)
            employeeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDataStack.CreateCoreStore()
        self.view.addSubview(self.pickerViewTextField)
        self.pickerViewTextField.backgroundColor = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        if employeeList.count > 0{
            employeeList.removeAll()
        }
        employeeList = AppDataStack.fetchAllEmployee()
    }
    
    @IBAction func AddEmployee(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addEmpSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "empDetailsSegue" {
            let indexPath = sender as! IndexPath
            let emp = employeeList[indexPath.row]
            
            let viewC = segue.destination as! EmpDetailViewController
            viewC.employee = emp
        }
    }
    
    func addPickerView(sender: UIBarButtonItem) {
        let pickerView: UIPickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        self.pickerViewTextField.inputAccessoryView = addToolBar()
        
        self.pickerViewTextField.inputView = pickerView
        self.pickerViewTextField.becomeFirstResponder()
    }
    
    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        addPickerView(sender: sender)
    }
    
    
    @IBAction func editButtonTuched(_ sender: UIBarButtonItem) {
    }

    
    func addToolBar ()-> UIToolbar {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.black
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.plain, target: self, action: #selector(EmployeeListViewController.tappedToolBarBtn))
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(EmployeeListViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "Select a Birth date"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        return toolBar
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func donePressed(sender: UIBarButtonItem) {
        self.pickerViewTextField.resignFirstResponder()
//        employeeList = AppDataStack.fetchEmployee(whereClouse: "department.sub == '\(selectedSubDepartment)'", whereClouse2: "department.designation == '\(selectedDesignation)'")
        
        let predicate = NSPredicate(format: "ANY department.sub == %@ && ANY department.designation == %@ && ANY department.name == %@", selectedSubDepartment,selectedDesignation,selectedDepartment)

        employeeList = AppDataStack.fetchEmployee(predicate: predicate)
        employeeTableView.reloadData()
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        self.pickerViewTextField.resignFirstResponder()
    }
    
//    self.monitor = CoreStore.monitorList(
//        From<Employee>(),
//            Where("age > 30"),
//                OrderBy(.ascending("name")),
//            Tweak { (fetchRequest) -> Void in
//                fetchRequest.fetchBatchSize = 20
//            }
//    )
//    self.monitor.addObserver(self)
    
}

//extension EmployeeListViewController: ListObserver {
//    typealias ListEntityType = Employee
//
//    func listMonitorDidChange(_ monitor: ListMonitor<Employee>) {
//        // ...
//    }
//    
//    func listMonitorDidRefetch(_ monitor: ListMonitor<Employee>) {
//        // ...
//    }
//}

extension EmployeeListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return filterDepartments.count
        }else if component == 2 {
            return filterSubDepartments.count
        }
        return filterDesignations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        if component == 1 {
            return filterDepartments[row]
        }else if component == 2 {
            return filterSubDepartments[row]
        }
        return filterDesignations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 1 {
            selectedDepartment = filterDepartments[row]
            selectedDepartmentRow = row
        }else if component == 2 {
            selectedSubDepartment = filterSubDepartments[row]
            selectedSubDepartmentRow = row
        }else {
            selectedDesignation = filterDesignations[row]
            selectedDesignationRow = row
        }
        applyFilter(selectedDepartmentRow: selectedDepartmentRow, selectedSubDepartmentRow: selectedSubDepartmentRow, selectedDesignationRow: selectedDesignationRow)
    }
    
    func applyFilter(selectedDepartmentRow: Int = 0, selectedSubDepartmentRow: Int = 0, selectedDesignationRow: Int = 0) {
        print(filterDepartments[selectedDepartmentRow],filterSubDepartments[selectedSubDepartmentRow],filterDesignations[selectedDesignationRow])
        selectedDepartment = filterDepartments[selectedDepartmentRow]
        selectedSubDepartment = filterSubDepartments[selectedSubDepartmentRow]
        selectedDesignation = filterDesignations[selectedDesignationRow]
    }
    
    
}

extension EmployeeListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "empCell") as! EmployeeListCell
        cell.employee = employeeList[indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "empDetailsSegue", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            let employee = self.employeeList[indexPath.row]
            AppDataStack.deleteEmployee(employee: employee, completion: { (success,error) in
                if success {
                    self.employeeTableView.beginUpdates()
                    self.employeeList.remove(at: indexPath.row)
                    self.employeeTableView.deleteRows(at: [indexPath], with: .automatic)
                    self.employeeTableView.endUpdates()
                }else{
                    print("Error \(String(describing: error))")
                }
            })
        }
    }


}