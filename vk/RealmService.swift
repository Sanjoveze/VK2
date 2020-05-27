//
//  RealmService.swift
//  vk
//
//  Created by Rafael Khanov on 21.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmService {
    
    let networkService = NetworkService()
    
    // MARK: - Groups
    
    func saveGroups(groups: [Groups]) {
        do {
            print(uiRealm.configuration.fileURL)
            uiRealm.beginWrite()
            uiRealm.add(groups, update: .modified)
            try uiRealm.commitWrite()
            
        } catch {
            print(error)
        }
    }
    
    func getGroups() {
        let method = "groups.get"
        let parametersName = "fields"
        let parametersDescription = "city, members_count"
        networkService.getRequest(
            method: method,
            parametersName: parametersName,
            parametersDescription: parametersDescription,
            parse: { data in
                try! JSONDecoder().decode(
                    ResponseGroups.self,
                    from: data
                )
        },
            completion: { groups in
              self.saveGroups(groups: groups.response.items)
        })
    }
    
    func loadGroups(completion: ([Groups]) -> ()) {
            let groups = uiRealm.objects(Groups.self)
            completion(Array(groups))
    }
    
    // MARK: - Friends
    
    func loadFriends(completion: ([Friends]) -> ()) {
            let friends = uiRealm.objects(Friends.self)
            completion(Array(friends))
    }
    
    func getFriends(){
        let requestMethod = "friends.get"
        let parametersName = "fields"
        let parametersDescription = "nickname, photo_50"

           networkService.getRequest(
               method: requestMethod,
               parametersName: parametersName,
               parametersDescription: parametersDescription,
               parse:  { data in
                   try! JSONDecoder().decode(
                       FriendsResponse.self,
                       from: data
                   )
               },
               completion: { friends in
                self.saveFriends(friends: friends.response.items)
           })
    }
    
    func saveFriends(friends: [Friends]) {
        do {
            print(uiRealm.configuration.fileURL!)
            uiRealm.beginWrite()
            uiRealm.add(friends, update: .modified)
            try uiRealm.commitWrite()
                  
        } catch {
            print(error)
        }
    }
}