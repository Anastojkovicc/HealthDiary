//
//  Appointments.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation


var appointmentList: [Appointment] = [
    Appointment(speciality: "Oftalmolog", note: "Konjuktivitis", date: Date(), medicationList: [Medication(name: "Floxal", consumption: "3x1 u oba oka 5 dana", archived: true), Medication(name: "Proculin", consumption: "po potrebi", archived: false)]),
    Appointment(speciality: "Dermatolog", note: "Ekcem", date: Date(), medicationList:
                    [Medication(name: "Pantenol", consumption: "Ujutru i uvece", archived: false)])
]


enum AppointmentsError: Error {
    case invalidParametars
}

class AppointmentsService {
    
    func getAppointmentsList(user: User, completion: @escaping(Result<[Appointment], AppointmentsError>) -> Void){
        
        completion(.success([Appointment].init()))
    }
    
    func deleteAppointment(appointment: Appointment, completion: @escaping(Result<Bool, AppointmentsError>) -> Void ){
        
        var currIndex = 0
        let allApp = appointmentList.count
        
        repeat{
            if appointmentList[currIndex].speciality == appointment.speciality && appointmentList[currIndex].note == appointment.note && appointmentList[currIndex].date == appointment.date {
                appointmentList.remove(at: currIndex)
                completion(.success(true))
                return
            }
            currIndex += 1
        } while (currIndex<=allApp)
    }
    
    func getAppointment(appointment:Appointment ,completion: @escaping(Result<Appointment, AppointmentsError>) -> Void){
        for app in appointmentList {
            if app.speciality == appointment.speciality && app.note == appointment.note && app.date == appointment.date {
                completion(.success(app))
            }
        }
    }
    
    func changeAppointment(old:Appointment , new: Appointment, completion: @escaping(Result<Bool, AppointmentsError>) -> Void){
        var index: Int!
        
        for (indexApp, element) in appointmentList.enumerated() {
            if element.speciality == old.speciality && element.date == old.date && element.note == old.note {
                index = indexApp
            }
        }
        
        if index != nil {
            appointmentList[index] = new
            completion(.success(true))
        } else {
            completion(.success(false))
        }
        
    }
}
