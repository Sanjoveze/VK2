//
//  LikeControl.swift
//  vk
//
//  Created by Rafael Khanov on 19.11.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit


protocol LikeControlDelegate: class {
    func likedPress()
}

class LikeControl: UIControl {

    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var count: UILabel!
    var isLiked = false
    var likesCount = 0
     
    public weak var delegate: LikeControlDelegate?
    
    override func draw(_ rect: CGRect) {
        count.text = "\(likesCount)"
        if isLiked {
            likeImage.image = UIImage(systemName: "heart.fill")
        } else {
            likeImage.image = UIImage(systemName: "heart")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setupGestureRecognzer()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupGestureRecognzer()
        
    
    }
    
    // MARK: - Privates
    
    private func setupGestureRecognzer() {
        delegate?.likedPress()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapOnLike))
            addGestureRecognizer(tapGR )
            tapGR.numberOfTapsRequired = 2
        }
    
    @objc private func tapOnLike() {
        likedPress()
    }
    
    private func likedPress() {
        
        isLiked.toggle()
        if isLiked {
            UIView.transition(with: likeImage, duration: 1, options: .transitionFlipFromBottom, animations: {
                self.likeImage.image = UIImage(systemName: "heart.fill")
            }, completion: nil)
            likesCount += 1
        } else {
            UIView.transition(with: likeImage, duration: 1, options: .transitionFlipFromBottom, animations: {
                self.likeImage.image = UIImage(systemName: "heart")
            }, completion: nil)
            likesCount -= 1
        }
        count.text = "\(likesCount)"
    }
    
    // MARK: - Public API
    
    public func configure(likes likesCount: Int, isLikedBuUser: Bool) {
        self.likesCount = likesCount
        self.isLiked = isLikedBuUser
        
    }

}
