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
        
        searchVM.addLatitudeLongitude(lat: Double(HomeViewModel.shared.userLatitude ?? "0") ?? 0.0, long: Double(HomeViewModel.shared.userLongitude ?? "0") ?? 0.0)
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
    @IBAction func onClickPopular(_ sender: UIButton) {
        if !onClickpopularBtn{
            popularBtn.select()
            distanceBtn.deselect()
            ratingBtn.deselect()
        }
        else{
            popularBtn.deselect()
        }
        onClickpopularBtn = !onClickpopularBtn
        searchVM.addSortBy(by: sender.title(for: .normal)?.uppercased() ?? "")
    }
    @IBAction func setRadius(_ sender: UITextField) {
        searchVM.addRadius(radius: sender.text ?? "0")
    }
    
    @IBAction func onClickDistance(_ sender: UIButton) {
        if !onClickdistanceBtn{
            distanceBtn.select()
            popularBtn.deselect()
            ratingBtn.deselect()
        }
        else{
            distanceBtn.deselect()
        }
        onClickdistanceBtn = !onClickdistanceBtn
        searchVM.addSortBy(by: sender.title(for: .normal)?.uppercased() ?? "")

    }
    
    @IBAction func onClickRating(_ sender: UIButton) {
        if !onClickratingBtn{
            ratingBtn.select()
            distanceBtn.deselect()
            popularBtn.deselect()
        }
        else{
            ratingBtn.deselect()
        }
        onClickratingBtn = !onClickratingBtn
        searchVM.addSortBy(by: sender.title(for: .normal)?.uppercased() ?? "")

    }
    
    @IBAction func onSearchType(_ sender: UITextField) {
        searchVM.addOption(text: sender.text ?? "")
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
        searchVM.expensiveRange(range: 1)
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
        searchVM.expensiveRange(range: 2)

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
        searchVM.expensiveRange(range: 3)

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
        searchVM.expensiveRange(range: 4)

    }
    @IBAction func onDoneClick(_ sender: Any) {
        searchVM.addFilters()
        searchVM.postFilter { (bodyText,  error, statusCode) in
            DispatchQueue.main.async {
                if let vc = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController {
                    vc.isSearch = false
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
        }
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Features"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
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
        searchVM.featuredDict[key] = !(searchVM.featuredDict[key] ?? false)
        print(searchVM.featuredDict)
    }
}
