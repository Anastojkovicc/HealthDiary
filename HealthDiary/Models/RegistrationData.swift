//
//  RegistrationData.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 1.3.22..
//

import Foundation

struct RegistrationData: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

struct LoginData: Encodable {
    let email: String
    let password: String
}
