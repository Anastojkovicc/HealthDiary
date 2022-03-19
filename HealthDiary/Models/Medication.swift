//
//  Medication.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

struct Medication {
    let id: String
    let name: String
    let consumption: String
    var isArchived: Bool
    var appointments: [Appointment]
    
    mutating func archived() {
        isArchived = true
    }
    
    mutating func active() {
        isArchived = false
    }
}

struct NewMedication: Encodable {
    let name: String
    let consumption: String
}
