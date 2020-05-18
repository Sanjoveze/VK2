//
//  GroupXibCell.swift
//  vk
//
//  Created by Rafael Khanov on 09.11.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class GroupXibCell: UITableViewCell {
    
    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        groupImageView.layer.cornerRadius = frame.height / 2
        groupImageView.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        UIView.animate(withDuration: 0.6, delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0,
                            options: [],
                            animations:  {
                            self.groupImageView.bounds.size.height *= 2
                               
             })
        

    
    }
    
}
