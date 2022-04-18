//
//  DataStorage.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 5.3.22..
//

import Foundation

class DataStorage {
    var loggedUser: User? {
        didSet{
            if let user = loggedUser{
                user.saveToDisk()
            } else {
                UserDefaults.standard.set(nil, forKey: "loggedInUser")
            }
        }
    }
    
    static let shared = DataStorage()
    
    private init(){}
}

