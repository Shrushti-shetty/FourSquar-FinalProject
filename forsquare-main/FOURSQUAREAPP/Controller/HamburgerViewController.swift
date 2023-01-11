//
//  HamburgerViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 31/12/22.
//

import UIKit

class HamburgerViewController: UIViewController {
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var feedBackButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var storageManager = StorageManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear",storageManager.isLoggedIn())
        if !storageManager.isLoggedIn(){
            
            userName.text = "LogIn"
            favouritesButton.isEnabled = false
            feedBackButton.isEnabled = false
            logoutButton.setTitle("Login", for: .normal)
        }
        else {
            userName.text = "Shrushti Shetty"
            favouritesButton.isEnabled = true
            feedBackButton.isEnabled = true
            logoutButton.setTitle("Logout", for: .normal)
        }
    }
    @IBAction func aboutUsButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController{
        navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func onClickLoginLogout(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        storageManager.resetLoggedIn()
    }
    @IBAction func onClickFeedbackButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as? FeedbackViewController{
        navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
