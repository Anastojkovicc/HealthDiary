//
//  Medication.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

struct Medication: Decodable {
    let id: String
    let name: String
    let consumption: String
    var isArchived: Bool
    
    mutating func archived() {
        isArchived = true
    }
    
    mutating func active() {
        isArchived = false
    }
}

struct MedicationDTO: Decodable {
    let id: String
    let name: String
    let consumption: String
    let isArchived: Bool
}

struct NewMedication: Encodable {
    let name: String
    let consumption: String
}
