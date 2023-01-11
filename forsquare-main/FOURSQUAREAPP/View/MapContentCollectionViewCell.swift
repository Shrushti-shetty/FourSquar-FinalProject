//
//  MapContentCollectionViewCell.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

class MapContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var placeExpense: UILabel!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var placeRating: UILabel!
    @IBOutlet weak var placeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
