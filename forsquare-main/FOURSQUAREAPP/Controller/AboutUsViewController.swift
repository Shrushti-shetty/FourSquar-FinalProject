//
//  AboutUsViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

class AboutUsViewController: UIViewController {
    var aboutUsVM = AboutUsViewModel()
    @IBOutlet weak var aboutUsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUsVM.fetchAboutUsDetails { (success, message, error) in
            DispatchQueue.main.async {
                if success ?? false {
                    self.aboutUsLabel.text = message
                }
                else {
                    self.aboutUsLabel.text = message
                }
            }
        }
    }
}
