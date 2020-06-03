//
//  Friends.swift
//  vk
//
//  Created by Rafael Khanov on 15.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import Foundation
import RealmSwift

 class FriendsResponse: Decodable {
     let response: FriendsArray
 }

 class FriendsArray: Decodable {
     let items: [Friends]
 }

 class Friends: Object, Decodable {
     @objc dynamic var userId = 0
     @objc dynamic var firstName = ""
     @objc dynamic var lastName = ""
     @objc dynamic var photo = ""
     
    override static func primaryKey() -> String? {
         return "userId"
     }
    
     enum CodingKeys: String, CodingKey{
         case firstName = "first_name"
         case lastName = "last_name"
         case userId = "id"
         case photo = "photo_50"
     }
     
     required init (from decoder: Decoder) throws {
         let value = try decoder.container(keyedBy: CodingKeys.self)
         self.userId = try value.decode(Int.self, forKey: .userId)
         self.firstName = try value.decode(String.self, forKey: .firstName)
         self.lastName = try value.decode(String.self, forKey: .lastName)
         self.photo = try value.decode(String.self, forKey: .photo)
     }
    
    required init() {}
}

 
