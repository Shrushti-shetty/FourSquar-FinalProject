//
//  LoactionManager.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 31/12/22.
//

import Foundation
import CoreLocation
class LocationManager: NSObject,CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLoaction(completion: @escaping ((CLLocation) -> Void)) {
        print("userlocation")
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationmanager gu")
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}

