//
//  SearchViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 07/01/23.
//

import Foundation
class SearchViewModel {
    var filterUrl = "https://app-foursquare-230104103641.azurewebsites.net/user/view/search?limit=9&page=1"
    var placesList = [Place]()
    
    var features = [String]()
    
    var featuredDict: [String: Bool] = [ : ]
    
    var filterParameters: [String:Any] = ["filter": [
        "option": "Manipal"
    ]
    ]
    
    var filteredList: [Place] = []
    
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
                self.featuredDict = temp
                completion(true, error)
            } else {
                completion(false, error)

            }
        }
    }
    
    func postFilter(completion: @escaping(String, Error?, Int) -> Void) {
        print(filterParameters,"parameter")
        var request = URLRequest(url: URL(string: filterUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONSerialization.data(withJSONObject: filterParameters, options: [])
            request.httpBody = data
            
        } catch {
            print("Error: cannot create JSON from data")
            return
            
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("Response", response.statusCode)
                let body = String(data: data!, encoding: .nonLossyASCII)
                print("Response body: \(String(describing: body))")
                guard let tempData = data else { return }
                do {
                    self.filteredList.removeAll()
                    if let jsonData = try JSONSerialization.jsonObject(with: tempData, options: .allowFragments) as? [[String: Any]] {
                        for place in jsonData {
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
                            self.filteredList.append(place)
                        }
                        completion(body ?? "Undefined Error, Sorry Try Again", nil, response.statusCode)
                    }
                    
                } catch {
                    print("this failed")
                    
                }
                
            }
            if error != nil {
                print(error?.localizedDescription as Any)
                completion("Undefined Error, Sorry Try Again", error, 0)
                
            }
            
        }.resume()
        
    }
    
    func addLatitudeLongitude(lat: Double, long: Double) {
        filterParameters["latitude"] = lat
        filterParameters["longitude"] = long
    }
    
    func addOption(text: String) {
        filterParameters["option"] = text
    }
    
    func addFilters() {
        var tempFilter: [String:Any] = [:]
        
        tempFilter["features"] = featuredDict
        
        filterParameters["filter"] = tempFilter
    }
    
    func addSortBy(by: String) {
        filterParameters["sortBy"] = by

    }
    
    func addRadius(radius: String) {
        filterParameters["radius"] = radius

    }
    
    func expensiveRange(range: Int) {
        filterParameters["expensiveRange"] = range

    }
    
}

