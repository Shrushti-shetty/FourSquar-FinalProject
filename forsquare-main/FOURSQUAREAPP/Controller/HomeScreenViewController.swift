//
//  ViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 30/12/22.
//

import UIKit
enum UserAction: String, CaseIterable{
    case nearyou = "Near you"
    case toppick = "Toppick"
    case popular = "Popular"
    case dinner = "Dinner"
    case coffee = "Coffee"
}
class HomeScreenViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var hamburgerButton: UIButton!
    @IBOutlet weak var hamburgerMenuView: UIView!
    @IBOutlet weak var hambugerMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    var pageVC: PageViewController?
    var homeViewModel = HomeViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.hambugerMenuWidthConstraint.constant = 0
        self.backgroundView.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        collectionView.selectItem(at: [0,0], animated: true, scrollPosition: .centeredHorizontally)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            if let vc = segue.destination as? PageViewController{
                self.pageVC = vc
                vc.indexDelegate = self
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hambugerMenuWidthConstraint.constant = 0
        self.backgroundView.isHidden = true
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.reloadData()
    }
    @IBAction func onClickCloseHamburger(_ sender: Any) {
        self.hambugerMenuWidthConstraint.constant = 0
        self.backgroundView.isHidden = true
    }
    
    @IBAction func onClickHamburgerButton(_ sender: Any) {
        self.hambugerMenuWidthConstraint.constant = 308
        self.backgroundView.isHidden = false
    }
    
    @IBAction func onClickSearchButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController{
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func onClickFilterButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController{
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    }
   
    
}
extension HomeScreenViewController: Swipe{
    func scrollToIndex(index: Int) {
        collectionView.scrollToItem(at: [0,index], at: .centeredHorizontally, animated: true)
        collectionView.selectItem(at: [0,index], animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserAction.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let userActionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? UserActionCollectionViewCell{
            userActionCell.configure(with: UserAction.allCases[indexPath.row].rawValue)
            cell = userActionCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? UserActionCollectionViewCell
        pageVC?.changeIndex(index: indexPath.row)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.selectItem(at: [0,indexPath.row], animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size - 10 , height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
