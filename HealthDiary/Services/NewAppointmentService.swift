//
//  NewAppointmentService.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

enum NewAppointmentError: Error {
    case invalidParametars
}

class NewAppointmentService {
    
    func saveAppointment(appointment: Appointment, completion: @escaping(Result<Bool, NewAppointmentError>) -> Void){
        appointmentList.append(appointment)
        
        completion(.success(true))

    }
}
