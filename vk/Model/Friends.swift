//
//  Friends.swift
//  vk
//
//  Created by Rafael Khanov on 15.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import Foundation

 class FriendsResponse: Decodable {
     let response: FriendsArray
     
     enum Keys: String, CodingKey {
         case response
     }
     
     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: Keys.self)
         self.response = try container.decode(FriendsArray.self, forKey: .response)
     }
 }

 class FriendsArray: Decodable {
     let items: [Friends]
     //let count: Int

//     enum Keys: String, CodingKey {
//         case items
//       //  case count
//     }
//     
//     required init(from decoder: Decoder) throws {
//         let container = try decoder.container(keyedBy: Keys.self)
//         self.items = try container.decode([Friends].self, forKey: .items)
//        // self.count = try container.decode(Int.self, forKey: .count)
//     }
     

 }

 class Friends: Decodable {
     var userId = 0
     var firstName = ""
     var lastName = ""
     var photo = ""
     
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
 }

 
