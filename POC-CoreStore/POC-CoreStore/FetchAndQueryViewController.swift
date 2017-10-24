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

class FetchAndQueryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var employeeTableView: UITableView!
    var employeeList: [(title: String, detail: String)] = []
    var selectedQuery = 0
    private let queryingItems = [
        (
            title: "Number of Employees",
            query: { () -> Any in
                
                return AppDataStack.sharedInstance.queryValue(
                    From<Employee>(),
                    Select<NSNumber>(.count(#keyPath(Employee.empNo)))
                    )!
        }
        ),
        (
            title: "Number of Female Employees",
            query: { () -> Any in
                
                return AppDataStack.sharedInstance.queryAttributes(
                    From<Employee>(),
                    Select(.count(#keyPath(Employee.empNo), as: "Female Emp Count")),
                    Where("gender == %d", 0)
                    )!
        }
        ),
        (
            title: "iOS Team",
            query: { () -> Any in
                
                return AppDataStack.sharedInstance.queryAttributes(
                    From<Employee>(),
                    Select(.count("empNo", as: "iOS Team Count")),
                    Where("department.sub == %@", "iOS")
                )!
        }
        )
    ]
    
    var pickerViewTextField: UITextField = UITextField(frame: CGRect(x: 0.0,y:0.0, width: UIScreen.main.bounds.width, height: 1.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.pickerViewTextField)
        self.pickerViewTextField.backgroundColor = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func addToolBar ()-> UIToolbar {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.black
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        let doneBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(EmployeeListViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)

        toolBar.setItems([flexSpace,doneBarBtn], animated: true)
        return toolBar
    }
    
    func donePressed(sender: UIBarButtonItem) {
        self.pickerViewTextField.resignFirstResponder()
        let item = self.queryingItems[selectedQuery]
        self.set(value: item.query(), title: item.title)
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
    }
    
    func set(value: Any?, title: String) {
        switch value {
        case (let array as [Any])?:
            self.employeeList = array.map { (item: Any) -> (title: String, detail: String) in
                (
                    title: String(describing: item),
                    detail: String(reflecting: type(of: item))
                )
            }
            
        case let item?:
            self.employeeList = [
                (
                    title: String(describing: item),
                    detail: String(reflecting: type(of: item))
                )
            ]
            
        default:
            self.employeeList = []
        }
        self.employeeTableView.reloadData()
    }
    
    @IBAction func queryButtonTapped(_ sender: UIBarButtonItem) {
        addPickerView(sender: sender)
    }
    
    
    //MARK: UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "queryCell", for: indexPath)
        let value = self.employeeList[indexPath.row]
        cell.textLabel?.text = value.title
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    
    //MARK: UIPickerView Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return queryingItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return queryingItems[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedQuery = row        
    }

}
