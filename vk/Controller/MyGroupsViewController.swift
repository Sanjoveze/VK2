//
//  MyGroupsViewController.swift
//  vk
//
//  Created by Rafael Khanov on 26.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage
import RealmSwift

class MyGroupsViewController: UITableViewController {
    
    let realmService = RealmService()
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
        if let sourseVC = segue.source as? AllGroupsViewController,
            let indexPath = sourseVC.tableView.indexPathForSelectedRow {
            let group = sourseVC.allGroups[indexPath.row]
            if !groups.contains(where: {$0.name == group.name}) {
                groups.append(group)
                realmService.saveGroups(groups: groups)
                sortedGroupDict = sortedArray(array: groups)
                tableView.reloadData()
            }
        }
    }
    var token: NotificationToken?
    var groups = [Groups]()
    
    var filterGroups = [Groups]()
    var sortedGroupDict: [Character: [Groups]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupXibCell", bundle: nil
        ), forCellReuseIdentifier: "GroupXibCell")
        
        
        realmService.loadGroups(completion: { result in
            self.groups = result
        })
        
        sortedGroupDict = sortedArray(array: groups)
        tableView.reloadData()
        
        let observGroups = uiRealm.objects(Groups.self)
        self.token = observGroups.observe{(changes: RealmCollectionChange) in
            switch changes {
            case .initial(let result):
                print(result)
            case .update(let result, _, _,_):
                print(result)
            case .error(let error):
                print(error)
            }
        }
    }
    
    func sortedArray(array: [Groups]) -> [Character:[Groups]] {
        var sortDict:[Character:[Groups]] = [:]
        
        array.forEach { group in
            guard let firstChar = group.name.first else { return }
            
            if var sortedArrayFromEachChar = sortDict[firstChar] {
                sortedArrayFromEachChar.append(group)
                sortDict[firstChar] = sortedArrayFromEachChar.sorted{ $0.name < $1.name }
            } else {
                sortDict[firstChar] = [group]
            }
        }
        
        return sortDict
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedGroupDict.keys.count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keySorted = sortedGroupDict.keys.sorted()
        return String(keySorted[section])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keySorted = sortedGroupDict.keys.sorted()
        return sortedGroupDict[keySorted[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "GroupXibCell", for:
                    indexPath) as? GroupXibCell
                else { preconditionFailure("GroupXibCell cannot be dequeued")
            }
            
            let firstChar = sortedGroupDict.keys.sorted()[indexPath.section]
            let groups = sortedGroupDict[firstChar]!
            let group = groups[indexPath.row]
            
            cell.groupTitleLabel.text = group.name
            let url = URL(string: group.image)!
            cell.groupImageView.af.setImage(withURL: url)
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        
            let firstChar = sortedGroupDict.keys.sorted()[indexPath.section]
            let sortGroups = sortedGroupDict[firstChar]!
            let group = sortGroups[indexPath.row]
            
            let initialSectionsCount = sortedGroupDict.keys.count

            groups.removeAll { $0.name == group.name }
           
            uiRealm.beginWrite()
            uiRealm.delete(group)
            try! uiRealm.commitWrite()

            sortedGroupDict = sortedArray(array: groups)

            if initialSectionsCount - sortedGroupDict.count == 0 {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                tableView.deleteSections(IndexSet([indexPath.section]), with: .automatic)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endEditing(true)
    }
}

extension MyGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filterGroups = groups
        } else {
            filterGroups = groups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        sortedGroupDict = sortedArray(array: filterGroups)
        tableView.reloadData()
    }
}
