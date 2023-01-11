//
//  RatingViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//https://app-foursquare-230104103641.azurewebsites.net/user/ratePlace?placeId=1&rate=7

import Foundation
class RatingViewModel {
    var header = ["Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzaGV0dHlzaHJ1c2h0aTE0M0BnbWFpbC5jb20iLCJleHAiOjE2NzMzNjk4MDksImlhdCI6MTY3MzMzMzgwOX0.YpB2STgroIf5PG40ZFdDQ_wLMYh0sAQR69SdFOJS4ti8JRuX475JAyYbYGpDosIT4xWS2fEX1hZN24w8X4TWkQ"]
    var placeId: Int = 0
    var rate: Int = 0
    func postRatings(completion: @escaping(Bool , Error?) -> Void) {
        NetworkManager().postData(url: "\(Urls.addRatingUrl.rawValue)?placeId=\(placeId)&rate=\(rate)", parameters: nil, header: header)
        
        {data,response,error in
            if response.statusCode == 200 {
                    completion(true,nil)
            }else if response.statusCode == 400 {
                if data != nil {
                    print("data", data)
                    completion(false,nil)
                }
            }
            else {
                completion(false,nil)
            }
        }
    }
   
}
