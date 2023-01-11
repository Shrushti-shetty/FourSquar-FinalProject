//
//  SearchViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 07/01/23.
//

import Foundation
class SearchViewModel {
    var placesList = [Place]()
    
    var features = [String]()
    
    var filter: [String:Bool] = [ : ]
    
    func fetchSearchData(option: String, completion: @escaping(Bool , Error?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/view/search?option=\(option)&latitude=\(HomeViewModel.shared.userLatitude ?? "19.0176142")&longitude=\(HomeViewModel.shared.userLongitude ?? "72.8561642")&page=10&limit=1")! as URL)
        print(request,"URLSSSS")
        NetworkManager().getData(at: request) { (data, error) in
            if let apiData = data {
                self.placesList.removeAll()
                guard let placeDetails = apiData as?  [[String: Any]] else {print("fetchHotelDetailserr1");return}
                for place in placeDetails{
                    guard let placeName = place["placeName"] as? String else {print("fetchHotelDetailserr2");return}
                    print(placeName)
                    guard let address = place["address"] as? String else {print("fetchHotelDetailserr3");return}
                    print(address)
                    guard let ratings = place["ratings"] as? Double else {print("fetchHotelDetailserr4");return}
                    print(ratings)
                    guard let phoneNumber = place["phoneNumber"] as? String else {print("fetchHotelDetailserr7");return}
                    print(phoneNumber)
                    guard let distance = place["distance"] as? Double else {print("fetchHotelDetailserr5");return}
                    print(distance)
                    guard let placeType = place["placeType"] as? String else {print("fetchHotelDetailserr6");return}
                    print(placeType)

                    let place = Place(placeName: placeName, address: address, ratings: ratings, phoneNumber: phoneNumber, distance: distance, placeType: placeType)
                    self.placesList.append(place)
                }
                completion(true, error)
            }
            completion(false, error)
        }
    }
    
    func fetchFeaturesData(completion: @escaping(Bool , Error?) -> Void) {
        
        var temp: [String:Bool] = [:]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/view/allFeatures")! as URL)
        print(request,"URLSSSS")
        NetworkManager().getData(at: request) { (data, error) in
            if let apiData = data {
                self.features.removeAll()
                guard let features = apiData as?  [String] else {print("fetchHotelDetailserr1");return}
                for feature in features{
                    self.features.append(feature)
                    temp[feature] = false
                }
                self.filter = temp
                completion(true, error)
            } else {
                completion(false, error)

            }
        }
    }
    
}

