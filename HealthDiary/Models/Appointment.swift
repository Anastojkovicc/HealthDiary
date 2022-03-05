//
//  Appointment.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

struct Appointment: Identifiable {
    let id = UUID()
    var speciality: String
    var note: String
    var date: Date
    var medicationList : [Medication]
}
