//
//  ContentTableViewCell.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 30/12/22.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeRatings: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var placeAdress: UILabel!
    @IBOutlet weak var placeDistance: UILabel!
    @IBOutlet weak var expense: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowOpacity = 0.18
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 2
        self.layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.2562607021)
            self.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(place: Place) {
        placeName.text = place.placeName
        placeRatings.text = String(place.ratings)
       // placeImage.image
        placeType.text = place.placeType
        placeAdress.text = place.address
        placeDistance.text = String(place.distance)
        //expense.text = place.
    }
}
