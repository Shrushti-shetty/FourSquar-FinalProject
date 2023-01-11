//
//  ContentViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 30/12/22.
//

import UIKit
protocol ReLoad {
    func loadData()
}

class ContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReLoad {
    
    @IBOutlet weak var tableView: UITableView!
    var homeViewModel = HomeViewModel.shared
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "MapView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MapView")
        homeViewModel.locationManager.requestAlwaysAuthorization()
        homeViewModel.locationManager.requestWhenInUseAuthorization()
        homeViewModel.locationManager.delegate = homeViewModel
        homeViewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if checkPermission() {
            loadData()
            
        }
        else {
            print("location access is denied")
        }
        
    }
    func checkPermission() -> Bool {
        var isPermitted = true
        switch homeViewModel.locationManager.authorizationStatus{
        case .authorizedAlways: isPermitted = true
        case .authorizedWhenInUse: isPermitted = true
        case .denied: isPermitted = false
        case .notDetermined: isPermitted = false
        case .restricted: isPermitted = false
            
        default: break
            
        }
        homeViewModel.isPermissionGranted = isPermitted
        return isPermitted
    }
    func loadData() {
        switch index {
        case 0: homeViewModel.fetchHotelDetails(userAction: "nearMe") { (data, error) in
            if data ?? false {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.homeViewModel.fetchLocation {
                    self.loadData()
                }
            }
        }
        
        case 1: homeViewModel.fetchHotelDetails(userAction: "topPicks") { (data, error) in
            if data ?? false {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        case 2: homeViewModel.fetchHotelDetails(userAction: "popular") { (data, error) in
            if data ?? false {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        case 3: homeViewModel.fetchHotelDetails(userAction: "Dinner") { (data, error) in
            if data ?? false {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        case 4: homeViewModel.fetchHotelDetails(userAction: "coffee") { (data, error) in
            if data ?? false {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
        default:
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.hotelDetailList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if index == 0 {
            return 160
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ContentTableViewCell
        cell?.placeName.text = homeViewModel.hotelDetailList[indexPath.row].placeName
        cell?.placeType.text = homeViewModel.hotelDetailList[indexPath.row].placeType
        cell?.placeAdress.text = homeViewModel.hotelDetailList[indexPath.row].address
        cell?.placeRatings.text = "\(round(homeViewModel.hotelDetailList[indexPath.row].ratings))"
//        cell?.placeDistance.text = String(homeViewModel.hotelDetailList[indexPath.row].distance)
        cell?.placeDistance.text = "\(round(homeViewModel.hotelDetailList[indexPath.row].distance))km"
        
        // cell?.placeImage.image = homeViewModel.hotelDetailList[indexPath.row].placeImage
        // cell?.placeImage.image = homeViewModel.hotelDetailList[indexPath.row].placeImage(expense)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            vc.detailViewModel = PlaceDetailsViewModel()
            vc.detailViewModel?.placeId = String(homeViewModel.hotelDetailList[indexPath.row].placeId)
            print(1236554, homeViewModel.hotelDetailList[indexPath.row].placeId)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MapView") as? MapView
        view?.getLocation()
        return view
    }
}
