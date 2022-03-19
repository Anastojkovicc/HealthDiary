//
//  User.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

struct User: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let appointments: [String]?
    
    init(id: String, firstName: String, lastName: String, email: String, password: String, appointments: [String]?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.appointments = appointments
    }
}
