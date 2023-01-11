//
//  AboutUs.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//

import Foundation
class AboutUsViewModel {
    
        let networkManager = NetworkManager()
        var currentPlace: PlaceDetailsModel?
        var placeId: String?
        
    
        func fetchAboutUsDetails(completion: @escaping((Bool?, String ,Error?) -> Void)){
            let request = NSMutableURLRequest(url: NSURL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/view/aboutUs")! as URL)

                request.httpMethod = "GET"
                request.allHTTPHeaderFields = nil
                self.networkManager.getData(at: request) { [self]data,error in
                    if let apiData = data{
                        guard let placeDetails = apiData as?  [String: Any] else { return }
                            guard let description = placeDetails["description"] as? String else {print("fetchHotelDetailserr2");return}
                            print(description)
                        completion(true,description,nil)

                        }
                    else {
                        completion(false,"Error in loading content!",nil)
                    }
                    
                    }
        
    }
}
