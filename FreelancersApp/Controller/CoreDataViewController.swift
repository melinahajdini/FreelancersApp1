//
//  CoreDataViewController.swift
//  FreelancersApp
//
//  Created by Melina on 30.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EmployeeCoreProtocol {
   
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var employeeTable: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    
    var toUpdate: Bool = false
    var employeeToUpdate: EmployeeModel?
    
    var employeesArray: [EmployeeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        //getEmployees()
        
        
        if(UserDefaults.standard.bool(forKey: "firstTime") == false){
                    //hera e pare ne app
                    print("first time in app")
                    UserDefaults.standard.setValue(true, forKey: "firstTime")
                    getEmployees()
                }else{
                    print("Not the first time in app")
                    //nuk eshte hera e pare ne app
                    readEmployees()
                }
        // Do any additional setup after loading the view.
    }
    
    
    func setupTable(){
        employeeTable.delegate = self
        employeeTable.dataSource = self
        employeeTable.register(UINib(nibName: "CoreDataTableViewCell", bundle: nil), forCellReuseIdentifier: "CoreDataTableViewCell")
    }
    
    func getEmployees(){
        EmployeeService.getEmployees {(success, employees, error) in
              if(success){
                  if let employees = employees{
                      self.employeesArray = employees
                      self.saveEmployees()
                      self.employeeTable.reloadData()
                  }
              }else{
                  print("getEmployees error = \(String(describing: error))")
              }
          }
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTable.dequeueReusableCell(withIdentifier: "CoreDataTableViewCell") as! CoreDataTableViewCell
        cell.setEmployeeDetails(employee: employeesArray[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 250
       }
    
    func saveEmployees(){
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context!)
            
            for empObj in employeesArray{
                let employee = NSManagedObject(entity: entity!, insertInto: context)
                employee.setValue(empObj.id, forKey: "id")
                employee.setValue(empObj.employee_name, forKey: "employee_name")
                employee.setValue(empObj.employee_salary, forKey: "employee_salary")
                employee.setValue(empObj.employee_age, forKey: "employee_age")
                
                do{
                    try context?.save()
                    print("Employee saved successfully")
                }catch{
                    print("Save Employees Failed!")
                }
            }
        }
    
    
    func readEmployees(){
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
            
            do{
                let results = try context?.fetch(request)
                
                for employee in ((results as? [NSManagedObject])!){
                    let empObj = EmployeeModel()
                    
                    empObj.id = (employee.value(forKey: "id") as! Int)
                    empObj.employee_name = (employee.value(forKey: "employee_name") as! String)
                    empObj.employee_salary = (employee.value(forKey: "employee_salary") as! Int)
                    empObj.employee_age = (employee.value(forKey: "employee_age") as! Int)
                    
                    employeesArray.append(empObj)
                }
                employeeTable.reloadData()
            }catch{
                print("Fetching posts failed")
            }
        }
    

    func deleteEmployee(employee: EmployeeModel) {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let context = appDelegate?.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    request.predicate = NSPredicate(format: "id = %@", "\(employee.id ?? 0)")
    
    print("employee id = \(employee.id ?? 0)")
    do{
        let results = try! context?.fetch(request)
        print("the objecta are : \(results)")

        for empObj in ((results as? [NSManagedObject])!){
            print("the object is: \(empObj)")
            context?.delete(empObj)

            do{
                try context?.save()
                readEmployees()
            }catch{
                print("could not delete post")
            }
        }
    }
   }
    
   func updateEmployee(employee: EmployeeModel) {
        createAlertToUpdatePost(employee: employee)
    
   }
    
    func createAlertToUpdatePost(employee: EmployeeModel){
           let alert = UIAlertController(title: "Update Post", message: "Change the following fields to update this post", preferredStyle: .alert)

           alert.addTextField { (nameTextF) in
            nameTextF.text = employee.employee_name
           }

           alert.addTextField { (salaryTextF) in
            salaryTextF.text = "\(employee.employee_salary ?? 0)"
           }

           alert.addTextField { (ageTextF) in
            ageTextF.text = "\(employee.employee_age ?? 0)"
           }

           alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
           }))

           alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
               employee.employee_name = alert.textFields![0].text!
               employee.employee_salary = Int(alert.textFields![1].text!)
               employee.employee_age = Int(alert.textFields![2].text!)

               self.updatePostCoreData(employee: employee)
           }))

           self.present(alert, animated: true, completion: nil)
       }
       
       func updatePostCoreData(employee: EmployeeModel){
           let appDelegate = UIApplication.shared.delegate as? AppDelegate
           let context = appDelegate?.persistentContainer.viewContext

           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        request.predicate = NSPredicate(format: "id = %@", "\(employee.id ?? 0)")


           do{
               let results = try! context?.fetch(request)
               for emp in ((results as? [NSManagedObject])!){
                   emp.setValue(employee.employee_name, forKey: "employee_name")
                   emp.setValue(employee.employee_salary, forKey: "employee_salary")
                emp.setValue(employee.employee_age, forKey: "employee_age")
                   do{
                       try context!.save()
                        print("data are updated")
                       readEmployees()
                   }catch{
                       print("save updated post failed")
                   }
               }
           }catch{
               print("failed")
           }
       }
    
//
//    func updateEmployee(employee: EmployeeModel) {
//        employeeToUpdate = employee
//
//        print("update id = \(employee.id ?? 0)")
//        nameTextField.text = employee.employee_name
//        salaryTextField.text = "\(employee.employee_salary ?? 0)"
//        ageTextField.text = "\(employee.employee_age ?? 0)"
//
//        update(employee: employee)
//    }
//
//    func update(employee: EmployeeModel){
//
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let context = appDelegate?.persistentContainer.viewContext
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
//            request.predicate = NSPredicate(format: "id = %@", "\(employee.id ?? 0)")
//        do{
//            let results = try! context?.fetch(request)
//            for emp in ((results as? [NSManagedObject])!){
//                emp.setValue(employee.employee_name, forKey: "employee_name")
//                emp.setValue(employee.employee_salary, forKey: "employee_salary")
//             emp.setValue(employee.employee_age, forKey: "employee_age")
//                do{
//                    try context!.save()
//                     print("data are updated")
//                    readEmployees()
//                }catch{
//                    print("save updated post failed")
//                }
//            }
//        }catch{
//            print("failed")
//        }
//        nameTextField.text = ""
//        salaryTextField.text = ""
//        ageTextField.text = ""
//    }
}
