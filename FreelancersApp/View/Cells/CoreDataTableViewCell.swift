//
//  CoreDataTableViewCell.swift
//  FreelancersApp
//
//  Created by Dajt on 30.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit

protocol EmployeeCoreProtocol {
    func deleteEmployee(employee: EmployeeModel)
    func updateEmployee(employee: EmployeeModel)
}
class CoreDataTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var employeeObj: EmployeeModel?
    
    var delegate: EmployeeCoreProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setEmployeeDetails(employee: EmployeeModel){
           employeeObj = employee
           idLabel.text = "Employee ID: \(employee.id ?? 0)"
           nameLabel.text = "Employee Name: \(employee.employee_name ?? "")"
           salaryLabel.text = "Employee Salary: \(employee.employee_salary ?? 0)"
           ageLabel.text = "Employee Age: \(employee.employee_age ?? 0)"
  
       }
    
    
    
    @IBAction func deleteButtonPress(_ sender: Any) {
        delegate?.deleteEmployee(employee: employeeObj!)
        
    }
    
    
    @IBAction func updateButtonPress(_ sender: Any) {
        
        delegate?.updateEmployee(employee: employeeObj!)
        
    }
    
}
