//
//  ReviewViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//

import Foundation
class ReviewViewModel {
    var placeId: String = ""
    
    var reviewList = [Review]()
    func fetchReviewData( completion: @escaping(Bool , Error?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/view/reviews?placeId=\(placeId)")! as URL)
        NetworkManager().getData(at: request) { (data, error) in
            if let apiData = data {
                self.reviewList.removeAll()
                guard let reviews = apiData as?  [[String: Any]] else {print("fetchHotelDetailserr1");return}
                for review in reviews{
                    guard let userName = review["userName"] as? String else {print("fetchHotelDetailserr2");return}
                    print(userName)
                    let profilePic = review["profilePic"] as? String
                    print(profilePic)
                    guard let description = review["description"] as? String else {print("fetchHotelDetailserr4");return}
                    print(description)
                    guard let reviewDate = review["reviewDate"] as? String else {print("fetchHotelDetailserr7");return}
                    print(reviewDate)
                    guard let placeName = review["placeName"] as? String else {print("fetchHotelDetailserr5");return}
                    print(placeName)
                    
                let review = Review(profilePicture: profilePic, userName: userName, review: description, date: reviewDate)
                    self.reviewList.append(review)
                }
                completion(true, error)
            }
            completion(false, error)
        }
    }
}
