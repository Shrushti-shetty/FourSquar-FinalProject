//
//  Storage Manager.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 06/01/23.
//

import Foundation
class StorageManager {
    static var shared = StorageManager()
    enum loginKey: String, CaseIterable {
        case loggedIn
        case userId
    }
    func isLoggedIn() -> Bool {
        UserDefaults.standard.bool(forKey: loginKey.loggedIn.rawValue)
    }
    
    func setLoggedIn() {
        UserDefaults.standard.setValue(true, forKey: loginKey.loggedIn.rawValue)
    }
    
    func resetLoggedIn() {
        print("Login Reset")
        UserDefaults.standard.setValue(false, forKey: loginKey.loggedIn.rawValue)
        print(isLoggedIn())
    }
}
