//
//  Groups.swift
//  vk
//
//  Created by Rafael Khanov on 26.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit
import Foundation

class ResponseGroups: Decodable {
    let response: Items
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try value.decode(Items.self, forKey: .response)
    }
}

class Items: Decodable {
    var items: [Groups]
    
    enum Keys: String, CodingKey {
        case items
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.items = try container.decode([Groups].self, forKey: .items)
    }
}

class Groups: Decodable {
    var id = 0
    var name = ""
    var image = ""

    enum GroupsKeys: String, CodingKey {
        case id
        case name
        case image = "photo_50"
    }

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: GroupsKeys.self)

        self.id = try value.decode(Int.self, forKey: .id)
        self.name = try value.decode(String.self, forKey: .name)
        self.image = try value.decode(String.self, forKey: .image)
    }
}
