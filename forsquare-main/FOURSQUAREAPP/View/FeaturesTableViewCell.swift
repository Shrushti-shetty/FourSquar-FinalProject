//
//  FeaturesTableViewCell.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

protocol SendAddFeatureAction {
    func toSendUserAction(index: Int)
}


class FeaturesTableViewCell: UITableViewCell {

    var delegate: SendAddFeatureAction?
    var featureClicked:Bool = false
    @IBOutlet weak var featuresLabel: UILabel!
    @IBOutlet weak var addFeatureButton: UIButton!
    
    @IBAction func onClickSelectFeature(_ sender: Any) {
        if !featureClicked{
            addFeatureButton.setImage(#imageLiteral(resourceName: "icons8-ok-30"), for: .normal)
            print("addFeatureButton",addFeatureButton.tag)
        }
        else{
            print("addFeatureButton2",addFeatureButton.tag)
            addFeatureButton.setImage(#imageLiteral(resourceName: "icons8-plus-math-30"), for: .normal)
        }
        featureClicked = !featureClicked
        delegate?.toSendUserAction(index: addFeatureButton.tag)
    }
    
}
