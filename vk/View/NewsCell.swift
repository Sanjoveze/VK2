//
//  NewsCell.swift
//  vk
//
//  Created by Rafael Khanov on 12.11.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var groupAvatarImageView: UIImageView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
