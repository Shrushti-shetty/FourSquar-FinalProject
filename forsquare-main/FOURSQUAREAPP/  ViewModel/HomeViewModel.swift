//
//  HomeViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import Foundation
import CoreLocation


enum Urls: String {
    case registerUrl = "https://app-foursquare-230104103641.azurewebsites.net/auth/register"
    case loginUrl = "https://app-foursquare-230104103641.azurewebsites.net/auth/login"
    case addReviewUrl = "https://app-foursquare-230104103641.azurewebsites.net/user/review"
    case addRatingUrl = "https://app-foursquare-230104103641.azurewebsites.net/user/ratePlace"
}
class HomeViewModel:  NSObject ,CLLocationManagerDelegate{
    static var shared = HomeViewModel()
    var hotelDetailList = [HomeModel]()
    var userLatitude: String?
    var userLongitude: String?
    var coordinate: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    let networkManager = NetworkManager()
    var isPermissionGranted: Bool = false
    var delegate: ReLoad?
    func fetchHotelDetails(userAction: String,completion: @escaping((Bool?, Error?) -> Void)){
        if userLatitude == nil{
            completion(false, nil)
        }
        else{
            var request = NSMutableURLRequest(url: NSURL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/view/\(userAction)?longitude=\(self.userLongitude ?? "72.8561642")&latitude=\(self.userLatitude ?? "19.0176142")&page=1&limit=100")! as URL)
            
//            if userAction == "nearMe" {
//                let url = NSMutableURLRequest(url: NSURL(string: "https://app-foursquare-230104103641.azurewebsites.net/user/view/\(userAction)?longitude=\(self.userLongitude ?? "72.8561642")&latitude=\(self.userLatitude ?? "19.0176142")&page=1&limit=100")! as URL)
//                request = url
//            }
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = nil
            self.networkManager.getData(at: request) { [self]data,error in
                if let apiData = data{
                    self.hotelDetailList.removeAll()
                    print(apiData,"73385124")
                    guard let hotelDetails = apiData as?  [[String: Any]] else {print("fetchHotelDetailserr1");return}
                    for question in hotelDetails{
                        guard let placeId = question["placeId"] as? Int64 else {print("fetchHotelDetailserr2");return}
      
                        guard let placeName = question["placeName"] as? String else {print("fetchHotelDetailserr3");return}

                        guard let placeType = question["placeType"] as? String else {print("fetchHotelDetailserr3");return}

                        guard let address = question["address"] as? String else {print("fetchHotelDetailserr4");return}
                        guard let phoneNumber = question["phoneNumber"] as? String else {print("fetchHotelDetailserr5");return}
                        guard let ratings = question["ratings"] as? Double else {print("fetchHotelDetailserr6");return}
                        print(ratings,"ratingssss")
                        guard let latitude = question["latitude"] as? Double else {print("fetchHotelDetailserr7");return}
                        guard let longitude = question["longitude"] as? Double else {print("fetchHotelDetailserr8");return}
                        guard let distance = question["distance"] as? Double else {print("fetchHotelDetailserr9");return}
                        let hotelDetailList = HomeModel(placeId: placeId, placeName: placeName,placeType: placeType, address: address, phoneNumber: phoneNumber, ratings: ratings, latitude: latitude, longitude: longitude, distance: distance)
                        self.hotelDetailList.append(hotelDetailList)
                    }
                    completion(true,nil)
                }
            }
        }
    }
    
    func fetchLocation(completion: @escaping (() -> Void) ){
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
            completion()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { print("failed loc value");return }
        print("loc value", locValue)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        coordinate = locValue
        userLatitude = String(locValue.latitude)
        userLongitude = String(locValue.longitude)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways: print("call authorization always")
            isPermissionGranted = true
            delegate?.loadData()
            
        case .authorizedWhenInUse: print("call authorization when in use")
            isPermissionGranted = true
            delegate?.loadData()
            
        default:
            break
        }
    }
    
}
