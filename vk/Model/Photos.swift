//
//  Photos.swift
//  vk
//
//  Created by Rafael Khanov on 15.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import Foundation

class ResponsePhoto: Decodable {
    let response: PhotosArrays

    enum ItemsKeys: String, CodingKey {
        case response
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: ItemsKeys.self)
        self.response = try value.decode(PhotosArrays.self, forKey: .response)
    }
}

class PhotosArrays: Decodable {
    var items: [Photos]

}

class Photos: Decodable {
    var ownerId = 0
    var sizes: [Sizes]
    var likes: UserLikes

    enum PhotosKeys: String, CodingKey {
        case ownerId = "owner_id"
        case sizes
        case likes
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: PhotosKeys.self)
        self.ownerId = try value.decode(Int.self, forKey: .ownerId)
        self.sizes = try value.decode([Sizes].self, forKey: .sizes)
        self.likes = try value.decode(UserLikes.self, forKey: .likes)
    }
}

class Sizes: Decodable {
    var type = ""
    var image = ""

    enum SizeKeys: String, CodingKey{
        case type
        case image = "url"
    }

    required init(from decoder: Decoder) throws {

        let value = try decoder.container(keyedBy: SizeKeys.self)
        self.type = try value.decode(String.self, forKey: .type)
        self.image = try value.decode(String.self, forKey: .image)

    }
}

class UserLikes: Decodable {
    var isLiked = 0
    var count = 0

    enum LikesKeys: String, CodingKey {
        case isLiked = "user_likes"
        case count
    }
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: LikesKeys.self)
        self.isLiked = try value.decode(Int.self, forKey: .isLiked)
        self.count = try value.decode(Int.self, forKey: .count)
    }
}
