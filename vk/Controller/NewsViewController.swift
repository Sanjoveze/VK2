//
//  NewsViewController.swift
//  vk
//
//  Created by Rafael Khanov on 12.11.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
//    var myGroups = [
//          Groups(image: UIImage(imageLiteralResourceName: "10"), name: "One"),
//          Groups(image: UIImage(imageLiteralResourceName: "20"), name: "Two"),
//          Groups(image: UIImage(imageLiteralResourceName: "30"), name: "Three"),
//          Groups(image: UIImage(imageLiteralResourceName: "40"), name: "Four"),
//          Groups(image: UIImage(imageLiteralResourceName: "50"), name: "Five")
//      ]
    
    var newsImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return  0 //myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { preconditionFailure("NewsCell cannot be deueued")}
        
//        let newsTitle = myGroups[indexPath.row].name
//        cell.groupTitleLabel?.text = newsTitle
//               
//        let groupImage = myGroups[indexPath.row].image
//        cell.groupAvatarImageView.image = groupImage
//        
//        let newsImage = myGroups[indexPath.row].image
//        cell.newsImageView.image = newsImage
        
        return cell
    }
    

}
