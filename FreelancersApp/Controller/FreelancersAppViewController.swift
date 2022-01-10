//
//  FreelancersAppViewController.swift
//  FreelancersApp
//
//  Created by Cacttus Education 08 on 3/20/21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit

class FreelancersAppViewController: UIViewController {


   
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userdefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logInPressed(_ sender: Any) {
        
//       let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//       let homeVC = mainStoryboard.instantiateViewController(identifier: "homeVC") as? HomeViewController
//        homeVC?.incomingUsername = "Test"
//       self.navigationController?.pushViewController(homeVC!, animated: true)
        
        
        
        
    }



    @IBAction func signUpPressed(_ sender: Any) {
        
      
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "loginToHome"){
            let destinationHome = segue.destination as! HomeViewController
            
            userdefaults.setValue(emailTextField.text, forKey: "email")

            destinationHome.incomingUsername = emailTextField.text!
                
            }
        
        if(segue.identifier == "signUpToLogin"){
            let homeVC = segue.destination as! SignUpViewController
            
                
            }
       
        }
        
      
        
    

}
