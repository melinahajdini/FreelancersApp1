//
//  CoreDataTableViewCell.swift
//  FreelancersApp
//
//  Created by Melina on 30.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit

protocol EmployeeProtocol {
    func deleteEmployee(ID: Int)
    func updateEmployee(employee: EmployeeModel)
}

class ApiTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeID: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeSalary: UILabel!
    @IBOutlet weak var employeeAge: UILabel!
    
    var employeeObj: EmployeeModel?
    
    var delegate: EmployeeProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setEmployeeDetails(employee: EmployeeModel){
           employeeObj = employee
           employeeID.text = "Employee ID: \(employee.id ?? 0)"
           employeeName.text = "Employee Name: \(employee.employee_name ?? "")"
           employeeSalary.text = "Employee Salary: \(employee.employee_salary ?? 0)"
           employeeAge.text = "Employee Age: \(employee.employee_age ?? 0)"
  
       }
    
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        delegate?.deleteEmployee(ID: employeeObj?.id ?? 0)
        
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        delegate?.updateEmployee(employee: employeeObj!)
        
    }
    
}
