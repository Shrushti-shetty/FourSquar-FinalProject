//
//  SearchBarClickTableViewCell.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 03/01/23.
//

import UIKit

class SearchBarClickTableViewCell: UITableViewCell {
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
