//
//  UserActionCollectionViewCell.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 30/12/22.
//

import UIKit

class UserActionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userActionLabel: UILabel!
    
    func configure(with userAction: String) {
        userActionLabel.text = userAction
    }
    override var isSelected: Bool{
        didSet {
            if isSelected {
                userActionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                userActionLabel.textColor = #colorLiteral(red: 0.3970022202, green: 0.3350331187, blue: 0.3747714162, alpha: 1)
            }
        }
    }
}
