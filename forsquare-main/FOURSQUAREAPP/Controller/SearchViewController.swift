//
//  SearchViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 02/01/23.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    
    var placeName = ["Manipal", "Udupi"]
    var placeimg: [UIImage] = [#imageLiteral(resourceName: "favourite_icon_selected") , #imageLiteral(resourceName: "login_bg")]
    var suggestion = ["Top Pick", "Lunch","Coffee","Dinner","NearYou"]
    var features = ["Add Credit Card", "Wifi", "Dog Friendly", "Add Credit Card", "Add Credit Card"]
    var names1 = ["Add Credit Card", "Wifi", "Dog Friendly", "Add Credit Card", "Add Credit Card"]
    let searchViewModel = SearchViewModel()
    @IBOutlet weak var searchBarClickView: UIView!
    @IBOutlet weak var nearView: UIView!
    @IBOutlet weak var nearByYouTableView: UITableView!
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var featureTableView: UITableView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var suggestionsTableView: UITableView!
    @IBOutlet weak var useMyCureentLoactionButtton: UIButton!
    @IBOutlet weak var selectFromMap: UIButton!
    @IBOutlet weak var mapViewCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearByYouTableView.delegate = self
        nearByYouTableView.dataSource = self
        suggestionsTableView.delegate = self
        suggestionsTableView.dataSource = self
        listTableView.delegate = self
        listTableView.dataSource = self
        featureTableView.delegate = self
        featureTableView.dataSource = self
        mapViewCollectionView.delegate = self
        mapViewCollectionView.dataSource = self
        listTableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "Cell")
        mapViewCollectionView.register(UINib(nibName: "MapContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mapViewCell")
        hideAllViews()
        
    }
    
    func hideAllViews() {
        self.searchBarClickView.isHidden = true
        self.nearView.isHidden = true
        self.listView.isHidden = true
        self.filterView.isHidden = true
        self.mapView.isHidden = true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (context) -> Void in
            self.mapViewCollectionView.reloadData()
        }
    }
    @IBAction func onClickSearchBar(_ sender: Any) {
        hideAllViews()
        self.searchBarClickView.isHidden = false
    }
    @IBAction func didTypeSearch(_ sender: UITextField) {
        hideAllViews()
        self.listView.isHidden = false
        searchViewModel.fetchSearchData(option: sender.text ?? "") { (sucess, error) in
            DispatchQueue.main.async { self.listTableView.reloadData() }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case nearByYouTableView:
            return placeName.count
        case suggestionsTableView:
            return 5
        case listTableView:
            return searchViewModel.placesList.count
        case featureTableView:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView{
        case nearByYouTableView:
            let cell = nearByYouTableView.dequeueReusableCell(withIdentifier: "searchCell") as? SearchBarClickTableViewCell
            cell?.placeNameLabel.text = placeName[indexPath.row]
            cell?.placeImage.image = placeimg[indexPath.row]
            return cell ?? UITableViewCell()
            
        case suggestionsTableView:
            let cell = suggestionsTableView.dequeueReusableCell(withIdentifier: "suggestionCell") as? SuggestionsTableViewCell
            cell?.suggestionLabel.text = suggestion[indexPath.row]
            return cell ?? UITableViewCell()
        case listTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ContentTableViewCell
            cell?.configure(place: searchViewModel.placesList[indexPath.row])
            return cell ?? UITableViewCell()
        case featureTableView:
            let cell = featureTableView.dequeueReusableCell(withIdentifier: "featuresCell") as? FeaturesTableViewCell
            cell?.featuresLabel.text = features[indexPath.row]
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapViewCell", for: indexPath) as? MapContentCollectionViewCell
        //        cell?.placeName.text = names1[indexPath.row]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        print("sizw", size)
        return CGSize(width: collectionView.bounds.width , height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
