//
//  UnknownCodingKey.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 1.3.22..
//

import Foundation

struct UnknownCodingKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}
