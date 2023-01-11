//
//  LoginButton.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//

import Foundation
import UIKit
class customLoginBtn: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonSetup()
    }
    
    func buttonSetup(){
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)
        self.layer.cornerRadius = 5
    }
}

