//
//  AddReviewViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 07/01/23.
//

import UIKit

class AddReviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var addReviewViewModel: AddReviewViewModel?
    
    @IBOutlet weak var reviewText: UITextView!
    
    @IBOutlet weak var addPhotoCollectionView: UICollectionView!
    
    var photos: [UIImage] = [UIImage(named: "aad_photo_icon_big")!]
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoCollectionView.delegate = self
        addPhotoCollectionView.dataSource = self
        AddReviewViewModel().addReview(completion: { (_, _) in
            
        })
     

    }
    func submitReview() {
        addReviewViewModel?.addReview { (_, _) in
            let alert = UIAlertController(title: "Message", message: "Review added successfully", preferredStyle: .alert)
            DispatchQueue.main.async {
                self.present(alert, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                        self.dismiss(animated: true, completion: nil)

                    }
                }
            }
        }
    }
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickSubmit(_ sender: Any) {
        addReviewViewModel?.imageList = photos
        addReviewViewModel?.reviewText = reviewText.text
        submitReview()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = addPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? UploadImageCollectionViewCell
        cell?.image.image = photos[indexPath.row]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size/4 - 4  , height: size/4 - 4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1{
            let imagePickerController = UIImagePickerController()
                imagePickerController.allowsEditing = false
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                present(imagePickerController, animated: true, completion: nil)
        }
        else {
            return
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        photos.insert(tempImage, at: 0)
        addPhotoCollectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
