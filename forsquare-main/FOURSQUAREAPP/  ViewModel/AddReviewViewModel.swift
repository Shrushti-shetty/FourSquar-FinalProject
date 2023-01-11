//
//  AddReviewViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 09/01/23.
//

import Foundation
import UIKit
var token = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzaGV0dHlzaHJ1c2h0aTE0M0BnbWFpbC5jb20iLCJleHAiOjE2NzMzNjk4MDksImlhdCI6MTY3MzMzMzgwOX0.YpB2STgroIf5PG40ZFdDQ_wLMYh0sAQR69SdFOJS4ti8JRuX475JAyYbYGpDosIT4xWS2fEX1hZN24w8X4TWkQ"
class AddReviewViewModel {
    var imageList: [UIImage] = [ #imageLiteral(resourceName: "Splashscreen"),#imageLiteral(resourceName: "CK"),#imageLiteral(resourceName: "background")]
    
    var placeId: String = "1"
    
    var reviewText: String = "Review Test random 10"
    
    func addReview(completion: @escaping(Bool , Error?) -> Void) {
        
        print(placeId)
        
        NetworkManager().postReview(images: imageList, placeId: placeId, review: reviewText) { success,error  in
            
            if success {
                
                print("succcess")
                
                completion(true,nil)
                
            }
            else {
                
                completion(false,nil)
                
            }
            
        }
    }
}
