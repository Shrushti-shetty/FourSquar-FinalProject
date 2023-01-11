//
//  customRoundLabel.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//

import Foundation
import UIKit
class customRoundLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 17.5
    }
}
