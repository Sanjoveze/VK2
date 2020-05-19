//
//  Groups.swift
//  vk
//
//  Created by Rafael Khanov on 26.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class ResponseGroups: Decodable {
    let response: Items
}

class Items: Decodable {
    var items: [Groups]
}

class Groups: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""

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
    
    required init() {}
}
