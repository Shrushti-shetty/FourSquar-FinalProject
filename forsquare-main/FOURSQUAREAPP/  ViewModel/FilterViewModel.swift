//
//  FilterViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Manish R T on 11/01/23.

//{
//"latitude":13.348679805589848,
//"longitude":74.77803032897326,
//"filter":{
//    "option":"manipal",
// "features":{
//    "family_friendly":true,
//    "outdoor_seating": true,
//    "dog_friendly": false,
//    "credit_card": true,
//    "delivery": true,
//    "parking": true,
//    "family_friendly": false,
//    "wifi": true,
//    "walkingDistance": true
//    }
//}
//}

import Foundation
class FilterViewModel  {
    var parameters: [String:Any] = ["filter": [
        "option": "Manipal"
    ]
    ]
    func postLiveScore(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping(String, [String: Any]? , Error?, Int) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = data
            
        } catch {
            print("Error: cannot create JSON from data")
            return
            
        }
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("Response", response.statusCode)
                let body = String(data: data!, encoding: .nonLossyASCII)
                print("Response body: \(String(describing: body))")
                guard let tempData = data else { return }
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments) as? [String: Any] {
                        completion(body ?? "Undefined Error, Sorry Try Again", jsonData, nil, response.statusCode)
                        
                    }
                    
                } catch {
                    print("this failed")
                    
                }
                
            }
            if error != nil {
                print(error?.localizedDescription as Any)
                completion("Undefined Error, Sorry Try Again", nil,error, 0)
                
            }
            
        }.resume()
        
    }
    func addLatitudeLongitude(lat: Double, long: Double) {
        parameters["latitude"] = lat
        parameters["longitude"] = long
    }
    
    func addOption(text: String) {
        var temp: [String: String] = [:]
        temp["option"] = text
        parameters["filter"] = text
    }
    
    func addFilters(outdoor_seating: Bool, dog_friendly: Bool, credit_card: Bool, delivery: Bool, parking: Bool, family_friendly: Bool, wifi: Bool, walkingDistance: Bool) {
        let filter: [String:Any] = parameters
        let option = filter["option"] as! String
        var tempFeatures: [String:Any] = [:]
        var tempFilter: [String:Any] = [:]
        
        if outdoor_seating {
            tempFeatures["outdoor_seating"] = true
        }
        else if dog_friendly {
            tempFeatures["dog_friendly"] = true
        }
        else if credit_card {
            tempFeatures["credit_card"] = true
        }
        else if delivery {
            tempFeatures["delivery"] = true
        }
        else if parking {
            tempFeatures["parking"] = true
        }
        else if family_friendly {
            tempFeatures["family_friendly"] = true
        }
        else if wifi {
            tempFeatures["wifi"] = true
        }
        else if walkingDistance {
            tempFeatures["walkingDistance"] = true
        }
        
        tempFilter["option"] = option
        tempFilter["features"] = tempFeatures
        
        parameters["filter"] = tempFilter
        print(parameters, "parameters")
        
    }
    
    
}
