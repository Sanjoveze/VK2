//
//  FriendXibCell.swift
//  vk
//
//  Created by Rafael Khanov on 09.11.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class FriendXibCell: UITableViewCell {
    @IBOutlet weak var myFriendLabel: UILabel!
    @IBOutlet weak var myFriendImageView: UIImageView!
    @IBOutlet weak var frameUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        myFriendImageView.layer.cornerRadius = frame.height / 2
        myFriendImageView.clipsToBounds = true
        
        frameUIView.layer.shadowColor = UIColor.black.cgColor
        frameUIView.layer.backgroundColor = UIColor.clear.cgColor
        frameUIView.layer.shadowColor = UIColor.black.cgColor
        frameUIView.layer.shadowOffset = .init(width: 3, height: 2)
        frameUIView.layer.shadowRadius = 2
        frameUIView.layer.shadowOpacity = 0.3
        frameUIView.layer.shadowPath = UIBezierPath.init(roundedRect: frameUIView.bounds,
                                                         cornerRadius: 150).cgPath
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        UIView.animate(withDuration: 0.6, delay: 0,
                            usingSpringWithDamping: 0.5,
                             initialSpringVelocity: 0,
                             options: [],
                             animations:  {
                                self.myFriendImageView.bounds.size.height *= 2
                            })
    }
    
}
