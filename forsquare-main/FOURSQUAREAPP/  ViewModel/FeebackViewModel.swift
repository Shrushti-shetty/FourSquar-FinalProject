//
//  FeebackViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 10/01/23.
//

import Foundation
class FeedbackViewModel {
    
    var url = "https://app-foursquare-230104103641.azurewebsites.net/user/feedback"
    
    var parameters: [String: Any] = [
            "content": "Four Square is a helpfull app in all terms"
        ]
    
    func getResult(completion: @escaping((Bool?, Error?) -> Void)) {
        let networkManager = NetworkManager()
        print(parameters)
        networkManager.postFeedbackData(url: url, parameters: parameters, completion: { (data, error) in
            print("Done")
        })
    }
}
