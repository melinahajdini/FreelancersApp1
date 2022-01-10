//
//  CoreDataViewController.swift
//  FreelancersApp
//
//  Created by Melina on 30.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit
import SkeletonView
import ANActivityIndicator
import SVProgressHUD

class ApiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EmployeeProtocol{
   
    
  

    @IBOutlet weak var employeeTable: UITableView!

    @IBOutlet weak var employeeName: UITextField!
    @IBOutlet weak var employeeSalary: UITextField!
    @IBOutlet weak var employeeAge: UITextField!
    
    
    @IBOutlet weak var addButton: UIButton!
    
   
    
    var toUpdate: Bool = false
    var employeeToUpdate: EmployeeModel?
    
    var employeesArray: [EmployeeModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

//        let gradient = SkeletonGradient(baseColor: .greenSea)
//        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
//        view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .none)
        setupTable()
        getEmployees()
        
        
        
    }
    
   
    
  
    
    func setupTable(){
        employeeTable.delegate = self
        employeeTable.dataSource = self
        employeeTable.register(UINib(nibName: "ApiTableViewCell", bundle: nil), forCellReuseIdentifier: "ApiTableViewCell")
    }
    
    func getEmployees(){
          EmployeeService.getEmployees { (success, employees, error) in
              if(success){
                  if let employees = employees{
                      self.employeesArray = employees
                      self.employeeTable.reloadData()
//                      self.view.hideSkeleton()
                  }
              }else{
                  print("getEmployees error = \(String(describing: error))")
              }
          }
      }
    
//    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return "ApiTableViewCell"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTable.dequeueReusableCell(withIdentifier: "ApiTableViewCell") as! ApiTableViewCell
        cell.setEmployeeDetails(employee: employeesArray[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 250
       }
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
    
        if(toUpdate){
            update(employee: employeeToUpdate!)
        }else{
            createEmployee()
        }
        
    }
    
    
    func createEmployee(){
        
        let name = employeeName.text
        let salary = employeeSalary.text
        let age = employeeAge.text
                
        EmployeeService.createEmployee(employeeName: name ?? "", employeeSalary: salary ?? "", employeeAge: age ?? "") { (success, error) in
                    if(success){
                        print("Employee is Saved")
                        self.employeeTable.reloadData()
                    }else{
                        print("createEmployee error = \(String(describing: error))")
                    }
                }
        
        employeeName.text = ""
        employeeSalary.text = ""
        employeeAge.text = ""
    }
    
    func deleteEmployee(ID: Int) {
         print("delete id = \(ID)")
         
         EmployeeService.deleteEmployee(id: ID) { (success, error) in
             if(success){
                 self.employeeTable.reloadData()
             }else{
                 print("deleteEmployee error = \(String(describing: error))")
             }
         }
     }
    
    func updateEmployee(employee: EmployeeModel) {
        employeeToUpdate = employee
        toUpdate = true
        print("update id = \(employee.id ?? 0)")
        employeeName.text = employee.employee_name
        employeeSalary.text = "\(employee.employee_salary ?? 0)"
        employeeAge.text = "\(employee.employee_age ?? 0)"
        
        addButton.setTitle("Update", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
    }
    
    func update(employee: EmployeeModel){
        
        EmployeeService.updateEmployee(employee: employee) { (success, error) in
            if(success){
                self.getEmployees()
            }else{
                print("Error update is: \(String(describing: error))")
            }
        }
        
        addButton.setTitle("Add New", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        toUpdate = false
        employeeName.text = ""
        employeeSalary.text = ""
        employeeAge.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "apiToCoreView"){
            let coreVC = segue.destination as! CoreDataViewController

            }
    }
    
}
