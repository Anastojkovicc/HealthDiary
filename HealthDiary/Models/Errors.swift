//
//  Errors.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 5.3.22..
//

import Foundation

enum GeneralError: Error {
    case decodingError
}

enum LoginError: Error {
    case invalidParametars
    case noUser
}

enum SignUpError: Error {
    case invalidParametars
}

enum AppointmentsError: Error {
    case invalidParametars
}

enum NewAppointmentError: Error {
    case invalidParametars
}

enum MedicationsError: Error {
    case invalidParametars
}
enum NewMedicationError: Error {
    case invalidParametars
}



