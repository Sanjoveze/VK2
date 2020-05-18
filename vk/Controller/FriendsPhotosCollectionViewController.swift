//
//  FriendsPhotosController.swift
//  vk
//
//  Created by Rafael Khanov on 26.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit
import AlamofireImage

class FriendsPhotosCollectionViewController: UICollectionViewController {
  
    var photos = [Photos]()
    
    var userID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let NS = NetworkService()
        let method = "photos.getAll"
        let parametersName = "owner_id"
        let parametersDescription = String(userID)
        NS.getRequest(
            method: method,
            parametersName: parametersName,
            parametersDescription: parametersDescription,
            parse: { data -> ResponsePhoto in
                try! JSONDecoder().decode(
                    ResponsePhoto.self,
                    from: data)
        }, completion: { [weak self] photos in
            guard let this = self else { return }
            this.photos = photos.response.items
            this.collectionView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    
   }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
        section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "FriendsPhotosCell", for: indexPath) as? FriendsPhotosCell
        else {
                preconditionFailure("FriendsPhotosCell ")
        }
        
        let photo = photos[indexPath.item]
        var sizeM = ""
        photo.sizes.forEach{ size in
            if size.type == "m" {
                sizeM = size.image
            }
        }
        let url = URL(string: sizeM)
        cell.FriendsPhotoImageView.af.setImage(withURL: url!)
 
        let countsOfLikes = photo.likes.count
        var isLiked: Bool 
        
        if photo.likes.isLiked == 0 {
            isLiked = false
        } else {
            isLiked = true
        }
        
        cell.configureLikesCount(likes: countsOfLikes, isLikedBuUser: isLiked)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotos"
        {
            let cell: FriendsPhotosCell = sender as! FriendsPhotosCell
            
            let image = cell.FriendsPhotoImageView.image
            
            let showPhotoViewController: ShowPhotosViewController = segue.destination as! ShowPhotosViewController
            
            showPhotoViewController.rootPhoto = image
            //showPhotoViewController.images = photos
            showPhotoViewController.keyRootPhoto = cell.key
            
        }
    }

}

extension FriendsPhotosCollectionViewController: LikeControlDelegate {
    func likedPress() {
        print(#function)
    }
    
   
}

  
