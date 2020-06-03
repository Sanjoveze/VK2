//
//  FriendsPhotosController.swift
//  vk
//
//  Created by Rafael Khanov on 26.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit
import AlamofireImage
import RealmSwift

class FriendsPhotosCollectionViewController: UICollectionViewController {
  
    var photos = [Photos]()
    
    var userID = 0
    
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let realmService = RealmService()
        realmService.getPhotos(userId: userID)
        realmService.loadPhoto(userId: userID){ result in
            self.photos = result
            collectionView.reloadData()
            
            let observPhotos = uiRealm.objects(Photos.self)
            self.token = observPhotos.observe{(changes: RealmCollectionChange)  in
                switch changes {
                case .initial(let result):
                    print(result)
                case .update(let result, _, _, _):
                    print(result)
                case .error(let error):
                    print(error)
                }
            }
        }
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
//        var sizeM = ""
//        photo.type.forEach{ size in
//            if size.type == "m" {
//                sizeM = size.image
//            }
//        }
        
        
        
        let url = URL(string: photo.urlImage)
        cell.FriendsPhotoImageView.af.setImage(withURL: url!)
 
        let countsOfLikes = photo.likesCount
        var isLiked: Bool 
        
        if photo.isLiked == 0 {
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

  
