//
//  AppDelegate.swift
//  vk
//
//  Created by Rafael Khanov on 18.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit
import RealmSwift

let uiRealm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
    }
}

