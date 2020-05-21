//
//  Photos.swift
//  vk
//
//  Created by Rafael Khanov on 15.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import Foundation
import RealmSwift

class ResponsePhoto: Decodable {
    let response: PhotosArrays
}

class PhotosArrays: Decodable {
    var items: [Photos]
}

class Photos: Object, Decodable {
    @objc dynamic var ownerId = 0
    @objc dynamic var type = ""
    @objc dynamic var urlImage = ""
    @objc dynamic var isLiked = 0
    @objc dynamic var likesCount = 0
    

    enum PhotosKeys: String, CodingKey {
        case ownerId = "owner_id"
        case sizes
        case likes
    }

    enum SizeKeys: String, CodingKey{
          case type
          case image = "url"
      }
    
    enum LikesKeys: String, CodingKey {
          case isLiked = "user_likes"
          case likesCount = "count"
      }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: PhotosKeys.self)
        self.ownerId = try value.decode(Int.self, forKey: .ownerId)
        
        var sizesValue = try value.nestedUnkeyedContainer(forKey: .sizes)
        
        let firstSizesValue = try sizesValue.nestedContainer(keyedBy: SizeKeys.self)
        self.type = try firstSizesValue.decode(String.self, forKey: .type)
        self.urlImage = try firstSizesValue.decode(String.self, forKey: .image)
        
        let likesValue = try value.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
        self.isLiked = try likesValue.decode(Int.self, forKey: .isLiked)
        self.likesCount = try likesValue.decode(Int.self, forKey: .likesCount)
    }
    
    required init() {}
}

