//
//  RegisterViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 05/01/23.
//

import UIKit

class RegisterViewController: UIViewController {
    var registerViewModel = RegistrationViewModel()
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userConfirmPassword: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    var storageManeger = StorageManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        if validateFeilds() {
            let user = User(userName: emailId.text!, email: emailId.text!, password: userPassword.text!, phoneNumber: userPhoneNumber.text!)
            registerViewModel.currentUser = user
            registerViewModel.registerUser { (sucess, error) in
                if sucess {
                    print("Sucessfully registerd")
                    self.storageManeger.setLoggedIn()
                }
                else {
                    print("Failed")
                }
            }
        }
    }
    func validateFeilds() -> Bool {
        var isValid = true
        if emailId.text == "" {
            isValid = false
        }
        if userPhoneNumber.text == "" {
            isValid = false
        }
        if userPassword.text == "" {
            isValid = false
        }
        if userConfirmPassword.text == "" {
            isValid = false
        }
        return isValid
    }


}
