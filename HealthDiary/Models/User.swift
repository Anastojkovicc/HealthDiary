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
    
    init(id: String, firstName: String, lastName: String, email: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case password
    }
    
    init(from decoder: Decoder) throws {
        let wrapper = try decoder.container(keyedBy: UnknownCodingKey.self)
        guard let firstKey = wrapper.allKeys.first else {
            throw GeneralError.decodingError
        }
        
        let container = try wrapper.nestedContainer(keyedBy: CodingKeys.self, forKey: firstKey)
        id =  wrapper.allKeys.first!.stringValue
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
    }
}
