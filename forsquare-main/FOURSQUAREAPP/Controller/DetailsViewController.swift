//
//  DetailsViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 02/01/23.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var typePlace: UILabel!
    @IBOutlet weak var ratingsButton: UIButton!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var ratingsPopUpView: UIView!
    @IBOutlet weak var mapViewAddress: UILabel!
    @IBOutlet weak var oneStar: UIButton!
    @IBOutlet weak var twoStar: UIButton!
    @IBOutlet weak var threeStar: UIButton!
    @IBOutlet weak var fourStar: UIButton!
    @IBOutlet weak var fiveStar: UIButton!
    @IBOutlet weak var overallRatings: UILabel!
    
    
    
    @IBOutlet weak var mapViewPhoneNumber: UILabel!
    var detailViewModel: PlaceDetailsViewModel?
    
    var rateVm = RatingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
       self.ratingsPopUpView.isHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        detailViewModel?.fetchPlaceDetails { success,error  in
            DispatchQueue.main.async {
                if success ?? false {
                    self.assignValueToFields()
                }
                else {
                    print("errroooorrr")
                }
            }
        }
    }
    
    func assignValueToFields() {
        if let place = detailViewModel?.currentPlace {
            placeName.text = place.placeName
            overViewLabel.text = place.overview
            typePlace.text = place.placeType
            let imageUrl = URL(string: place.placePhoto)
            let data = try? Data(contentsOf: imageUrl!)
            placeImage.image = UIImage(data: data!)
            overallRatings.text = String(place.ratings)
            let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            addPin(coordinate: coordinate)
        }
    }
    
    func addPin(coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        self.mapView.addAnnotation(pin)
        
    }
    
    @IBAction func onClickRatings(_ sender: UIButton) {
       self.ratingsPopUpView.isHidden = false
        rateVm.placeId = Int((detailViewModel?.currentPlace!.placeId) ?? 0)
        
    }
    
    @IBAction func starClick(_ sender: UIButton) {
        switch sender {
        case oneStar:
            print("oneStar")
            oneStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            twoStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            threeStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            fourStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            fiveStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            rateVm.rate = 2
           
        case twoStar:
            print("twoStar")
            oneStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            twoStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            threeStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            fourStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            fiveStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            rateVm.rate = 4


        case threeStar:
            print("threeStar")
            oneStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            twoStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            threeStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            fourStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            fiveStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            rateVm.rate = 6


        case fourStar:
            print("fourStar")
            oneStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            twoStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            threeStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            fourStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            fiveStar.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
            rateVm.rate = 8

          
        case fiveStar:
            print("fiveStar")
            oneStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            twoStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            threeStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            fourStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            fiveStar.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
            rateVm.rate = 10

           
        default:
        print("Default")

        }
        
    }
    @IBAction func onClickCloseButton(_ sender: Any) {
         self.ratingsPopUpView.isHidden = true

    }
    @IBAction func onClickSubmit(_ sender: Any) {
        rateVm.postRatings { (success, error) in
            if success {
                let alert = UIAlertController(title: "Message", message: "Ratings added successfully", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true) {
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                            self.dismiss(animated: true, completion: nil)

                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: "Message", message: "Failed to add ratings", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true) {
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                            self.dismiss(animated: true, completion: nil)

                        }
                    }
                }
            }
            

        }
       self.ratingsPopUpView.isHidden = true
        
    }
    @IBAction func onClickReview(_ sender: Any) {
        print("reviewClicked")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController{
            vc.reviewVM = ReviewViewModel()
            vc.reviewVM.placeId = "\(self.detailViewModel?.currentPlace?.placeId ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onClickPhotosButton(_ sender: Any) {
        print("PhotosClicked")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as? PhotosViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func configure() {
        
    }
    @IBAction func onClickAddReview(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddReviewViewController") as? AddReviewViewController{
            let addReviewVM = AddReviewViewModel()
            addReviewVM.placeId = detailViewModel?.placeId ?? ""
            vc.addReviewViewModel = addReviewVM
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
