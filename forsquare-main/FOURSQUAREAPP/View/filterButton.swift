//
//  filterButton.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//

import Foundation
import UIKit
class CustomFilterButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.layer.borderWidth = 1.3
        self.layer.borderColor = #colorLiteral(red: 0.2078431373, green: 0.07450980392, blue: 0.2156862745, alpha: 1)
    }
    
    func select(){
        self.layer.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.07450980392, blue: 0.2156862745, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }
    
    func deselect(){
        self.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.setTitleColor(#colorLiteral(red: 0.2078431373, green: 0.07450980392, blue: 0.2156862745, alpha: 1), for: .normal)
    }
}
