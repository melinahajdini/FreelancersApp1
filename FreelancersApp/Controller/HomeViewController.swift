//
//  HomeViewController.swift
//  FreelancersApp
//
//  Created by Cacttus Education 08 on 3/20/21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    var incomingUsername = String()

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var freelancerTable: UITableView!
    
    var text = String()

    var freelancerArray: [Freelancer] = []

    var userdefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //usernameLabel.text = incomingUsername
        self.freelancerTable.tableHeaderView = self.headerView()
        self.freelancerTable.tableFooterView = self.footerView()
        setupUsersTable()
        createFreelancer()
//        text = userdefaults.string(forKey: "email") ?? "ska kurgja"
//        usernameLabel.text = text
        print("User defaults string is: \(incomingUsername)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "homeToMainView"){
            let mainVC = segue.destination as! MainViewController

            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        if let data = userdefaults.object(forKey: "email"){
            if let message = data as? String{
                self.usernameLabel.text = message
            }
        }
    }
 
    private func headerView() -> UIView{
           let header = UIView(frame: CGRect(x: 0, y: 0, width: self.freelancerTable.frame.width, height: 50))
               view.backgroundColor = UIColor.green
        
              return header
        
    }

    func footerView() -> UIView{
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.freelancerTable.frame.width, height: 50))
            view.backgroundColor = .green
        
            return footer
        }
    
    func setupUsersTable(){
        freelancerTable.dataSource = self
        freelancerTable.delegate = self
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freelancerArray.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "freelancerCell")
          
          
          if let profileImageView = cell?.viewWithTag(1) as? UIImageView{
              profileImageView.image = UIImage(named: freelancerArray[indexPath.row].profilePicture ?? "")
            
          }
          
          if let fullNameLabel = cell?.viewWithTag(2) as? UILabel{
              fullNameLabel.text = freelancerArray[indexPath.row].fullName
                }
          
          if let professionLabel = cell?.viewWithTag(3) as? UILabel{
              professionLabel.text = freelancerArray[indexPath.row].profession
            
         }
        
          if let experienceLabel = cell?.viewWithTag(4) as? UILabel{
                    experienceLabel.text = freelancerArray[indexPath.row].experienceWith
                }
          
          return cell!
        
        
        
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let freelancerDetailsVC = storyboard.instantiateViewController(identifier: "freelancerDetails") as! FreelancerDetailsViewController
        freelancerDetailsVC.freelancerObj = freelancerArray[indexPath.row]
        
        self.navigationController?.pushViewController(freelancerDetailsVC, animated: true)
    }


    
    func createFreelancer(){
        var freelancer = Freelancer()
        freelancer.fullName = "Astrit Kurtishaj"
        freelancer.profession = "Mobile Developer"
        freelancer.profilePicture = "titi"
        freelancer.experienceWith = "Android, Swift, laravel, javascriptAndroid, Swift, laravel, javascript"
        
        freelancerArray.append(freelancer)
        
        
        freelancer.fullName = "Rea Spahiu"
        freelancer.profession = "BackEnd Developer"
        freelancer.profilePicture = "rea"
        freelancer.experienceWith = "Laravel"
               
        freelancerArray.append(freelancer)
        
        freelancer.fullName = "Melina Hajdini"
        freelancer.profession = "Web Developer"
        freelancer.profilePicture = "meli"
        freelancer.experienceWith = "JavaScript, Angular"
               
        freelancerArray.append(freelancer)
         
        freelancer.fullName = "Jessica Alba"
        freelancer.profession = "Actress"
        freelancer.profilePicture = "jessicaalba"
        freelancer.experienceWith = "Movie actress"
               
        freelancerArray.append(freelancer)
        
        freelancer.fullName = "Tom Cruise"
        freelancer.profession = "Action movie actor"
        freelancer.profilePicture = "photo"
        freelancer.experienceWith = "Movies, Piano"
               
        freelancerArray.append(freelancer)
        
        freelancer.fullName = "Megan Fox"
        freelancer.profession = "Actress"
        freelancer.profilePicture = "meganfox"
        freelancer.experienceWith = "Linguist"
                      
        freelancerArray.append(freelancer)
        
        freelancerTable.reloadData()
    }

}
