//
//  Session.swift
//  vk
//
//  Created by Rafael Khanov on 12.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import Foundation

class Session {
    private init() {}
    public static var shared = Session()
    
    var token = ""
    var userID = 0
}
