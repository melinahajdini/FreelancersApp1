//
//  MainViewController.swift
//  FreelancersApp
//
//  Created by Melina on 15.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
  
    

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet var menuView: UIView!
    
    @IBOutlet weak var menuTable: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    

    var isMenuOpen: Bool = false
    
    var menuItems = ["Freelancers", "TextField", "Web View","Map View"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenu()
        setUpMenuTable()
        addHomeView()
        addMapView()
        addWebView()
        addTextField()
        
        //scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        //addTapGestureRecognizer()
        //super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "mainToApiView"){
            let apiVC = segue.destination as! ApiViewController

            }
    }

    @IBAction func menuButtonPressed(_ sender: Any) {
        
        if(isMenuOpen == false){
                              openMenu()
                          }else{
                              closeMenu()
                          }
    }
    
    
    func setupMenu(){
        menuView.frame = CGRect(x: self.view.frame.size.width,y: topView.frame.size.height, width: 2/3 * (self.view.frame.size.width), height: self.view.frame.size.height - topView.frame.size.height)
           self.view.addSubview(menuView)
    }
    
    func openMenu(){
          isMenuOpen = true
          UIView.animate(withDuration: 0.3) {
              self.menuView.frame = CGRect(x: self.view.frame.size.width, y: self.topView.frame.size.height, width: -2/3 * (self.view.frame.size.width), height: self.view.frame.size.height - self.topView.frame.size.height)
          }
      }
      
      func closeMenu(){
          isMenuOpen = false
          UIView.animate(withDuration: 0.3) {
              self.menuView.frame = CGRect(x:  self.view.frame.size.width, y: self.topView.frame.size.height, width: 2/3 * (self.view.frame.size.width), height: self.view.frame.size.height - self.topView.frame.size.height)
          }
      }
    
    func setUpMenuTable(){
        menuTable.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "menuCell")
        menuTable.delegate = self
        menuTable.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuTableViewCell
                    
        if let itemNameLabel = cell.viewWithTag(10) as? UILabel{
            itemNameLabel.text = menuItems[indexPath.row]
        }
        return cell
    }
    
    //notification task
   

    func addHomeView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: "homeVC") as! HomeViewController
        self.addChild(homeVC)
        homeVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
//            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
//            scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
           scrollView.addSubview(homeVC.view)
           homeVC.didMove(toParent: self)
         }
       
        func addMapView(){
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let mapVC = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
              self.addChild(mapVC)
              mapVC.view.frame = CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
//              scrollView.contentSize = CGSize(width: 2 * scrollView.frame.width, height: scrollView.frame.height)
//              scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
            scrollView.addSubview(mapVC.view)
           mapVC.didMove(toParent: self)
           
       }
       
       func addWebView(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let webVC = storyboard.instantiateViewController(identifier: "WebViewController") as! WebViewController
            self.addChild(webVC)
            webVC.view.frame = CGRect(x: 2 * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
//            scrollView.contentSize = CGSize(width: 3 * scrollView.frame.width, height: scrollView.frame.height)
//           scrollView.scrollRectToVisible(CGRect(x: 2 * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
           scrollView.addSubview(webVC.view)
           webVC.didMove(toParent: self)
    }
    
    func addTextField(){
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let textFieldVC = storyboard.instantiateViewController(identifier: "TextFieldViewController") as! TextFieldViewController
         self.addChild(textFieldVC)
         textFieldVC.view.frame = CGRect(x: 3 * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
//         scrollView.contentSize = CGSize(width: 4 * scrollView.frame.width, height: scrollView.frame.height)
//        scrollView.scrollRectToVisible(CGRect(x: 3 * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
        scrollView.addSubview(textFieldVC.view)
        textFieldVC.didMove(toParent: self)
 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: Notification.Name("MenuItemSelected"), object: nil, userInfo: ["selectedItem":"\(indexPath.row)"])

        //posto notification
        //Notification.post(notiname, "U Shtyp childi 1"
        if indexPath.row == 0{
                scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
                    scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
                  } else if indexPath.row == 1 {
                    scrollView.contentSize = CGSize(width: 4 * scrollView.frame.width, height: scrollView.frame.height)
                        scrollView.scrollRectToVisible(CGRect(x: 3 * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
                    
                  } else if indexPath.row == 2 {
                    scrollView.contentSize = CGSize(width: 3 * scrollView.frame.width, height: scrollView.frame.height)
                        scrollView.scrollRectToVisible(CGRect(x: 2 * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
                    
                  }  else {
                    scrollView.contentSize = CGSize(width: 2 * scrollView.frame.width, height: scrollView.frame.height)
                        scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
                    
                    
                  }
                  closeMenu()
    }
    
    
    
    
}
