//
//  User.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

struct User: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let appointments: [String]?
    
   func saveToDisk(){
        guard let data = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.set(data, forKey: "loggedInUser")
    }
}
