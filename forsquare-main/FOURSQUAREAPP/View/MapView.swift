//
//  MapView.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 03/01/23.
//

import UIKit
import MapKit
import CoreLocation
class MapView: UITableViewHeaderFooterView,CLLocationManagerDelegate{
    @IBOutlet weak var mapViewForMap: MKMapView!
    let locationManager = CLLocationManager()
    var homeViewModel = HomeViewModel.shared
    var userLatitude: String?
    var userLongitude: String?
    
    func getLocation(){
        mapViewForMap.delegate = self
        if homeViewModel.isPermissionGranted{
            self.homeViewModel.fetchLocation() {
                self.addPin()
            }
        }
        
    }
    
    func addPin() {
        let pin = MKPointAnnotation()
        if let coordinate = self.homeViewModel.coordinate{
            pin.coordinate = coordinate
            self.mapViewForMap.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
            self.mapViewForMap.addAnnotation(pin)
        } else {
            self.getLocation()
        }
        
    }
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        print("loactionmahger")
    //        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    //        print("locations = \(locValue.latitude) \(locValue.longitude)")
    //        self.userLatitude = String(locValue.latitude)
    //        homeViewModel.coordinate =
    //        self.userLongitude = String(locValue.longitude)
    //        homeViewModel.userLatitude = userLatitude
    //        homeViewModel.userLongitude = userLongitude
    //
    //    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("pin")
        let anview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        anview.image = #imageLiteral(resourceName: "rating_icon_selected")
        return anview
    }
}
