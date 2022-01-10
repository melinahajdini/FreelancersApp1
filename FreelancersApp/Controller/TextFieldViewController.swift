//
//  TextFieldViewController.swift
//  FreelancersApp
//
//  Created by Melina on 15.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {

    var textField = UITextField()
    var textField2 = UITextField()
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextFields()
        addTapGestureRecognizer()
        
    }
    
    
    func addTextFields(){
        
        label.frame = CGRect(x: 10, y: 30, width: self.view.frame.width - 10, height: 15)
        label.text = "Enter text in text fields and click on the screen"
        self.view.addSubview(label)
        
        textField.frame = CGRect(x: 10, y: 100, width: self.view.frame.width-20, height: 40)
        textField.placeholder = "Enter text here..."
        self.view.addSubview(textField)
        
        textField2.frame = CGRect(x: 10, y: 180, width: self.view.frame.width-20, height: 40)
        textField2.placeholder = "Enter text here..."
        self.view.addSubview(textField2)
    }
    
    func addTapGestureRecognizer(){
           let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        let alert = UIAlertController(title: "\(String(describing: textField.text ?? ""))", message:"\(String(describing: textField2.text ?? ""))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
      }
   

}
