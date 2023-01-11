//
//  HomeModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import Foundation
class HomeModel {
        var placeId: Int64
        var placeName: String
        var placeType: String
        var address: String
        var phoneNumber: String
        var ratings: Double
        var latitude: Double
        var longitude: Double
        var distance: Double

        init(placeId: Int64, placeName: String,placeType: String, address: String, phoneNumber: String, ratings: Double,latitude: Double, longitude: Double, distance: Double) {
            self.placeId = placeId
            self.placeName = placeName
            self.placeType = placeType
            self.address = address
            self.phoneNumber = phoneNumber
            self.ratings = ratings
            self.latitude = latitude
            self.longitude = longitude
            self.distance = distance
        }
}
