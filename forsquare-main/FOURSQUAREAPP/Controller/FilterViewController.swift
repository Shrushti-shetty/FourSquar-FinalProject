//
//  FilterViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 02/01/23.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var ratingBtn: CustomFilterButton!
    @IBOutlet weak var distanceBtn: CustomFilterButton!
    @IBOutlet weak var popularBtn: CustomFilterButton!
    @IBOutlet weak var lowPrice: CustomFilterButton!
    @IBOutlet weak var affordablePrice: CustomFilterButton!
    @IBOutlet weak var highPrice: CustomFilterButton!
    @IBOutlet weak var expensivePrice: CustomFilterButton!
    
    @IBOutlet weak var featuresTableView: UITableView!
    
    var searchVM = SearchViewModel()
    var onClickratingBtn: Bool = false
    var onClickdistanceBtn: Bool = false
    var onClickpopularBtn: Bool = false
    
    var onClicklowPriceBtn: Bool = false
    var onClickaffordablePriceBtn: Bool = false
    var onClickhighPriceBtn: Bool = false
    var onClickexpensivePriceBtn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuresTableView.delegate = self
        featuresTableView.dataSource = self
        
        let vm = FilterViewModel()
    
        vm.addFilters(outdoor_seating: true, dog_friendly: true, credit_card: false, delivery: true, parking: false, family_friendly: false, wifi: false, walkingDistance: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        searchVM.fetchFeaturesData { (success, error) in
            DispatchQueue.main.async {
                if success {
                    self.featuresTableView.reloadData()
                }
                else {
                    print("error1234")
                }
            }
        }
    }
    @IBAction func onClickPopular(_ sender: Any) {
        if !onClickpopularBtn{
            popularBtn.select()
        }
        else{
            popularBtn.deselect()
        }
        onClickpopularBtn = !onClickpopularBtn
    }
    
    @IBAction func onClickDistance(_ sender: Any) {
        if !onClickdistanceBtn{
            distanceBtn.select()
        }
        else{
            distanceBtn.deselect()
        }
        onClickdistanceBtn = !onClickdistanceBtn
    }
    
    @IBAction func onClickRating(_ sender: Any) {
        if !onClickratingBtn{
            ratingBtn.select()
        }
        else{
            ratingBtn.deselect()
        }
        onClickratingBtn = !onClickratingBtn
    }
    
    
    @IBAction func onClickLowPrice(_ sender: Any) {
        if !onClicklowPriceBtn{
            
            lowPrice.select()
            affordablePrice.deselect()
            highPrice.deselect()
            expensivePrice.deselect()
        }
        else{
            lowPrice.deselect()
            affordablePrice.deselect()
            highPrice.deselect()
            expensivePrice.deselect()
        }
        
        onClicklowPriceBtn = !onClicklowPriceBtn
    }
    
    @IBAction func onClickAffordablePrice(_ sender: Any) {
        if !onClickaffordablePriceBtn{
            
            lowPrice.deselect()
            affordablePrice.select()
            highPrice.deselect()
            expensivePrice.deselect()
        }
        else{
            lowPrice.deselect()
            affordablePrice.deselect()
            highPrice.deselect()
            expensivePrice.deselect()
        }
        onClickaffordablePriceBtn = !onClickaffordablePriceBtn
    }
    @IBAction func onClickHighPrice(_ sender: Any) {
        if !onClickhighPriceBtn{
            
            lowPrice.deselect()
            affordablePrice.deselect()
            highPrice.select()
            expensivePrice.deselect()
        }
        else{
            lowPrice.deselect()
            affordablePrice.deselect()
            highPrice.deselect()
            expensivePrice.deselect()
        }
        onClickhighPriceBtn = !onClickhighPriceBtn
    }
    
    @IBAction func onClickExpensivePrice(_ sender: Any) {
        if !onClickexpensivePriceBtn{
            
            lowPrice.deselect()
            affordablePrice.deselect()
            highPrice.deselect()
            expensivePrice.select()
        }
        else{
            lowPrice.deselect()
            affordablePrice.deselect()
            highPrice.deselect()
            expensivePrice.deselect()
        }
        onClickexpensivePriceBtn = !onClickexpensivePriceBtn
    }
}
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.features.count - 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featuresTableView.dequeueReusableCell(withIdentifier: "featuresCell") as? FeaturesTableViewCell
        cell?.delegate = self
        cell?.featuresLabel.text = searchVM.features[indexPath.row].replacingOccurrences(of: "_", with: " ").capitalized
        cell?.addFeatureButton.tag = indexPath.row
        return cell!
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Features"
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 70
//    }
    
}
extension FilterViewController: SendAddFeatureAction {
    func toSendUserAction(index: Int) {
        let key = searchVM.features[index]
        searchVM.filter[key] = !(searchVM.filter[key] ?? false)
        print(searchVM.filter)
    }
}
