//
//  FriendsPhotosCell.swift
//  vk
//
//  Created by Rafael Khanov on 26.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class FriendsPhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var FriendsPhotoImageView: UIImageView!

    @IBInspectable var isLikePress: Bool = false
    
    @IBOutlet var likeControl: LikeControl!
    
    var key: Int = 0
    
    
    // MARK: - Public API
    
    public func configureLikesCount(likes likesCount: Int, isLikedBuUser: Bool) {
        likeControl.configure(likes: likesCount, isLikedBuUser: isLikedBuUser)
    }
    
}


