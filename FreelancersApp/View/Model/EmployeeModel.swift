//
//  EmployeeModel.swift
//  FreelancersApp
//
//  Created by Melina on 30.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import Foundation
import SwiftyJSON

class EmployeeModel: NSObject{
    
    var id: Int?
    var employee_name: String?
    var employee_salary: Int?
    var employee_age: Int?
    
    
    static func createEmployee(json: JSON) -> EmployeeModel?{
            let employee = EmployeeModel()
            
            if let ID = json["id"].int{
                employee.id = ID
            }
            
            if let employeeName = json["employee_name"].string{
                employee.employee_name = employeeName
            }
            
            if let employeeAge = json["employee_age"].int{
                employee.employee_age = employeeAge
            }
            
            
            if let employeeSalary = json["employee_salary"].int{
                employee.employee_salary = employeeSalary
            }
            
            return employee
        }
        
        static func createEmployeeArray(jsonArray: [JSON]) -> [EmployeeModel]? {
            var employeesArray: [EmployeeModel] = []
            
            for jsonObj in jsonArray{
                if let employee = createEmployee(json: jsonObj){
                    employeesArray.append(employee)
                }
            }
            
            return employeesArray
        }
}
