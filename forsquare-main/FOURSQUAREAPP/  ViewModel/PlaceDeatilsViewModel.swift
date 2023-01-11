//
//  PlaceDeatilsViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 10/01/23.
//

import Foundation
class PlaceDetailsViewModel {
    let networkManager = NetworkManager()
    var currentPlace: PlaceDetailsModel?
    var placeId: String?
    func fetchPlaceDetails(completion: @escaping((Bool?, Error?) -> Void)){
        let request = NSMutableURLRequest(url: NSURL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/view/placeDetail?placeId=\(placeId!)")! as URL)

            request.httpMethod = "GET"
            request.allHTTPHeaderFields = nil
            self.networkManager.getData(at: request) { [self]data,error in
                if let apiData = data{

                    guard let placeDetails = apiData as?  [String: Any] else { return }
                    
                        guard let placeId = placeDetails["placeId"] as? Int64 else {print("fetchHotelDetailserr2");return}
                        print(placeId)
                        guard let placeName = placeDetails["placeName"] as? String else {print("fetchHotelDetailserr3");return}
                        print(placeName)
                        guard let placeType = placeDetails["placeType"] as? String else {print("fetchHotelDetailserr3");return}
                        print(placeType)
                        guard let address = placeDetails["address"] as? String else {print("fetchHotelDetailserr4");return}
                        print(address)
                        guard let phoneNumber = placeDetails["phoneNumber"] as? String else {print("fetchHotelDetailserr5");return}
                        print(phoneNumber)
                        guard let ratings = placeDetails["ratings"] as? Double else {print("fetchHotelDetailserr6");return}
                        print(ratings)
                        guard let latitude = placeDetails["latitude"] as? Double else {print("fetchHotelDetailserr7");return}
                        print(latitude)
                        guard let longitude = placeDetails["longitude"] as? Double else {print("fetchHotelDetailserr8");return}
                        print(longitude)
                        guard let photo = placeDetails["placePhoto"] as? String else {print("fetchHotelDetailserr9");return}
                        guard let overview = placeDetails["overview"] as? String else {print("fetchHotelDetailserr9");return}
                        guard let typeDetail = placeDetails["typeDetail"] as? String else {print("fetchHotelDetailserr9");return}
                        let place = PlaceDetailsModel(placeId: placeId, placeName: placeName, address: address, phoneNumber: phoneNumber, ratings: ratings, latitude: latitude, longitude: longitude, placePhoto: photo, placeType: placeType, overview: overview, typeDetail: typeDetail)
                    self.currentPlace = place
                    }
                    completion(true,nil)
                }
            }
        
    
}
