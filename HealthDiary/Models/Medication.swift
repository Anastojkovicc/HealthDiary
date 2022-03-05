//
//  Medication.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

struct Medication {
    var name: String
    var consumption: String
    var archived: Bool
    
    mutating func Archived() {
            archived = true
        }
    
    mutating func Active() {
            archived = false
        }
}
