//
//  FeedbackViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

class FeedbackViewController: UIViewController {
    @IBOutlet weak var feedbackText: UITextView!
    var viewModel = FeedbackViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        viewModel.parameters["content"] = feedbackText.text
        viewModel.getResult { (success, error) in
            //            if success  {
            //                       let alert = UIAlertController(title: "Message", message: "Ratings added successfully", preferredStyle: .alert)
            //                       DispatchQueue.main.async {
            //                           self.present(alert, animated: true) {
            //                               DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            //                                   self.dismiss(animated: true, completion: nil)
            //
            //                               }
            //                           }
            //                       }
            //                   }
            //            else {
            //                        let alert = UIAlertController(title: "Message", message: "Failed to add ratings", preferredStyle: .alert)
            //                        DispatchQueue.main.async {
            //                            self.present(alert, animated: true) {
            //                                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            //                                    self.dismiss(animated: true, completion: nil)
            //
            //                                }
            //                            }
            //                        }
            //                    }
            //        }
            //        navigationController?.popViewController(animated: true)
        }
    }
}
        
        
    
    



