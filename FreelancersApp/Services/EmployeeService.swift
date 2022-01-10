//
//  EmployeeService.swift
//  FreelancersApp
//
//  Created by Melina on 30.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EmployeeService: NSObject{
   
    class func getEmployees(completionHandler: @escaping(_ success: Bool, _ employees: [EmployeeModel]?, _ error: Error?) -> Void){
         let getEmployeesURL = "https://dummy.restapiexample.com/api/v1/employees"
         
         AF.request(getEmployeesURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
             switch response.result{
             case .success(let data):
                 let jsonData = JSON(data)
                 
                if let employeesArray = EmployeeModel.createEmployeeArray(jsonArray: jsonData["data"].array ?? []){
                    completionHandler(true, employeesArray, nil)
                }
             case .failure(let error):
                 completionHandler(false, nil, error)
             }
         }
     }
    
    
    class func createEmployee(employeeName: String, employeeSalary: String, employeeAge: String, completionHandler: @escaping(_ success: Bool, _ error: Error?) -> Void){
            let createEmployeeURL = "https://dummy.restapiexample.com/api/v1/create"
            
            let parameters: [String: String] = [
                "name": employeeName,
                "salary": employeeSalary,
                "age": employeeAge
            ]
            
            AF.request(createEmployeeURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                switch(response.result){
                case .success(let data):
                    print("employee created: \(data)")
                    completionHandler(true, nil)
                case .failure(let error):
                    completionHandler(false, error)
                }
            }
        }
    
    class func deleteEmployee(id: Int, completionHandler: @escaping(_ success: Bool, _ error: Error?) -> Void){
           let deleteURL = "https://dummy.restapiexample.com/api/v1/delete/\(id)"
           
           AF.request(deleteURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                print("deleteEmployee response data = \(response)")
            switch response.result{
               case .success(let data):
                   
                   completionHandler(true, nil)
               case .failure(let error):
                print("error here = \(error)")
                completionHandler(false, error)
               }
           }
       }
       
       class func updateEmployee(employee: EmployeeModel, completionHandler: @escaping(_ success: Bool, _ error: Error?) -> Void){
           let updateEmployeeURL = "https://dummy.restapiexample.com/api/v1/update/\(String(describing: employee.id)))"
           
           let parameters: [String: Any] = [
               "name": employee.employee_name ?? "",
               "salary": employee.employee_salary ?? "",
               "age": employee.employee_age ?? ""
           ]
           
           AF.request(updateEmployeeURL, method: .put, parameters: parameters  , encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
               switch response.result{
               case .success(let data):
                   print("updateEmployee response data = \(data)")
                   completionHandler(true, nil)
               case .failure(let error):
                   completionHandler(false, error)
               }
           }
       }
    
}
