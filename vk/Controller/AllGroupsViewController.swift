//
//  AllGroupsViewController.swift
//  vk
//
//  Created by Rafael Khanov on 26.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class AllGroupsViewController: UITableViewController {
    
    let networkService = NetworkService()
  
    
    @IBOutlet weak var searchBar: UISearchBar! {
          didSet {
              searchBar.delegate = self
          }
    }
    
    var allGroups = [Groups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupXibCell", bundle: nil), forCellReuseIdentifier: "GroupXibCell")
 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupXibCell", for:
            indexPath) as? GroupXibCell
        else {
            preconditionFailure("All GroupXibCell cannot be deueued")
        }
        
        let groupTitle = allGroups[indexPath.row].name
        cell.groupTitleLabel?.text = groupTitle
        
            let group = allGroups[indexPath.row]
            
            let url = URL(string: group.image)!
            cell.groupImageView.af.setImage(withURL: url)      
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addSelectedGroup", sender: nil)
    }
}

extension AllGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            let method = "groups.search"
            let parametersName = "q"
            let parametersDescription = searchText
            networkService.getRequest(
                method: method,
                parametersName: parametersName,
                parametersDescription: parametersDescription,
                parse: { data in
                    try! JSONDecoder().decode(
                        ResponseGroups.self,
                        from: data
                    )
            }, completion: { [weak self] groups in
                guard let this = self else { return }
                this.allGroups = groups.response.items
                this.tableView.reloadData()
            })
        }
    }
}
