//
//  ReviewViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

class ReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var suggestion = ["Top Pick", "Lunch","Coffee","Dinner","NearYou"]
    var placeimg: [UIImage] = [#imageLiteral(resourceName: "favourite_icon_selected"), #imageLiteral(resourceName: "rating_icon_unselected"),#imageLiteral(resourceName: "rating_icon_unselected"),#imageLiteral(resourceName: "rating_icon_unselected"),#imageLiteral(resourceName: "rating_icon_unselected")]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var placeName: UILabel!
    
    var reviewVM: ReviewViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        reviewVM.fetchReviewData { (success, error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        
    }
    
    @IBAction func onClickReview(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddReviewViewController") as? AddReviewViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewVM.reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewTableViewCell
        cell?.userReview.text = reviewVM.reviewList[indexPath.row].review
        if let photUrlString = reviewVM.reviewList[indexPath.row].profilePicture {
            if let data = try? Data(contentsOf: URL(string: photUrlString)!) {
                cell?.userProfile.image = UIImage(data: data)
            }
        }
        return cell!
    }
    
}
