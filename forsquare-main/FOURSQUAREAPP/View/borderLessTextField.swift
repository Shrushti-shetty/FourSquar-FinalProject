//
//  borderLessTextField.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 11/01/23.
//

import Foundation
import UIKit
class BorderLessTextField: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.borderStyle = UITextField.BorderStyle.none
    }
        
}
