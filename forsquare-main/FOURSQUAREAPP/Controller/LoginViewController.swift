//
//  LoginViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 30/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    var registerViewModel = RegistrationViewModel()
    var storageManager = StorageManager.shared
    @IBOutlet weak var userEmailId: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func onClickLogin(_ sender: Any) {
        func validateFeilds() -> Bool {
            var isValid = true
            if userEmailId.text == "" {
                isValid = false
            }
            if userPassword.text == "" {
                isValid = false
            }
            return isValid
        }

        if validateFeilds() {
            let user = User(userName: "", email: userEmailId.text!, password: userPassword.text!, phoneNumber: "")
            registerViewModel.currentUser = user
            registerViewModel.loginUser { (sucess, error) in
                if sucess {
                   
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
                        self.storageManager.setLoggedIn()
                    }
                    print("Sucessfully logged in")
                }
                else {
                    print("Failed")
                    self.storageManager.resetLoggedIn()
                }
            }
        }
        
    }
    @IBAction func onClickSkipButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        storageManager.resetLoggedIn()
        print(storageManager.isLoggedIn(),"check")
    }
}
