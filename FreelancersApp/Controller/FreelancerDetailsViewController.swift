//
//  FreelancerDetailsViewController.swift
//  FreelancersApp
//
//  Created by Student 08 on 3/24/21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit

class FreelancerDetailsViewController: UIViewController {

    
    @IBOutlet weak var freelancerImage: UIImageView!
    
    @IBOutlet weak var freelancerName: UILabel!
    
    @IBOutlet weak var freelancerProfession: UILabel!
    
    @IBOutlet weak var freelancerExperience: UILabel!
    
    var freelancerObj: Freelancer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        freelancerImage.image = UIImage(named: freelancerObj?.profilePicture ?? "")
        freelancerName.text = freelancerObj?.fullName
        freelancerProfession.text = freelancerObj?.profession
        freelancerExperience.text = freelancerObj?.experienceWith
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
