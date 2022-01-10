//
//  WebViewController.swift
//  FreelancersApp
//
//  Created by Melina on 15.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
import NVActivityIndicatorView

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate{

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWeb()
        activityIndicator.startAnimating()
        //indicator!.showGradientSkeleton()
        //SVProgressHUD.show()
        loadPage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("MenuItemSelected"), object: nil)
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        SVProgressHUD.show(withStatus: "It's working...")
//    }
    @objc func methodOfReceivedNotification(notification: Notification) {
       
        let userInfo = notification.userInfo as! [String: Any]
        print("user info = \(userInfo)")
        
    }

    func loadPage(){
        //SVProgressHUD.show()
          let url = URL(string: "https://linkedin.com")
          let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
      }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.isHidden = true
//       SVProgressHUD.dismiss()
    }

    func setupWeb(){
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
     
}
