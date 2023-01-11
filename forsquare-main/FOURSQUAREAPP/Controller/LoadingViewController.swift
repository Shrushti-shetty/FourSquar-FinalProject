//
//  LoadingViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 06/01/23.
//

import UIKit

class LoadingViewController: UIViewController {

    var storageManager = StorageManager.shared
    private var loggedIn: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
//        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
//        navigationController?.pushViewController(vc!, animated: true)
        loggedIn = storageManager.isLoggedIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if storageManager.isLoggedIn() == true {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
                    navigationController?.pushViewController(vc!, animated: true)
        }
        else if storageManager.isLoggedIn() == false{
                    let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                    navigationController?.pushViewController(vc!, animated: true)
        }
        else {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                    navigationController?.pushViewController(vc!, animated: true)
        }
    }
  

}
