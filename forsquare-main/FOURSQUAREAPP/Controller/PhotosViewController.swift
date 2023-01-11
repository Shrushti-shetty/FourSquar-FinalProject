//
//  PhotosViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 05/01/23.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
  

}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCollectionViewCell
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size/3 - 4  , height: size/3 - 4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "FullImageViewController") as? FullImageViewController
        vc?.hotelName = "Taj"
        navigationController?.pushViewController(vc!, animated: true)
       // present(vc!, animated: true, completion: nil)
    }
    
    
}



