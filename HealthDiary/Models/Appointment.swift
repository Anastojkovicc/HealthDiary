//
//  Appointment.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

struct Appointment: Decodable {
    let id: String
    let type: String
    let note: String
    let date: Date
    var medications : [Medication]
}

struct AppointmentShort: Decodable {
    let id: String
    let type: String
    let note: String
    let date: Date
}

struct NewAppointmentData: Encodable {
    let type: String
    let date: Date
    let note: String
    var userId: String
    var medications: [NewMedication]
}




