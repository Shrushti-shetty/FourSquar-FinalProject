//
//  FullImageViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 05/01/23.
//

import UIKit

class FullImageViewController: UIViewController {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var uploadDate: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var tapped: Bool = true
    
    
    var hotelName: String = ""
    var imageUrl: String = ""
    var user: String = ""
    var date: String = ""
    var profileUrl: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.isHidden = false
        self.bottomView.isHidden = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        photo.isUserInteractionEnabled = true
        photo.addGestureRecognizer(tapGestureRecognizer)
        placeName.text = hotelName
        //assign
    }
   
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if tapped {
            self.tapped = !tapped
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.topView.isHidden = true
                self.bottomView.isHidden = true
                })
        }
        else{
            self.tapped = !tapped
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.topView.isHidden = false
                self.bottomView.isHidden = false
                })
        }
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
}
