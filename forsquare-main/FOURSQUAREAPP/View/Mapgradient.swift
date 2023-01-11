//
//  Mapgradient.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//

import Foundation
import UIKit


class Gradient: UIView {

    var topColor: UIColor =  .white

    var bottomColor: UIColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.09498073626)

    
    let gradientLayer = CAGradientLayer()
    override func layoutSubviews() {

       

        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)

        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.0, 0.8, 1.0]

        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)

    }

}


