//
//  Appointments.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation
import Alamofire


class AppointmentsService {
    
    struct UserID: Encodable {
        let userId: String
    }
    
    func getAppointmentsList(user: User, completion: @escaping(Result<[Appointment], AppointmentsError>) -> Void){
        let request = RequestFactory.makeRequest(method: .get,
                                                 path: "/appointments",
                                                 queryItems: [
                                                    URLQueryItem(name: "userId", value: "\(user.id)")
                                                 ]
        )
        
        AF.request(request)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let appointmentsDTO = try decoder.decode([AppointmentDTO].self, from: data)
                        var appointments : [Appointment] = []
                        for appointment in appointmentsDTO{
                            let newAppointment = Appointment.init(id: appointment.id, type: appointment.type, note: appointment.note, date: appointment.date, medications: [])
                            appointments.append(newAppointment)
                        }
                        completion(.success(appointments))
                    } catch {
                        completion(.failure(.invalidParametars))
                    }
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(.invalidParametars))
                }
            }).cURLDescription(calling: { description in
                print(description)
            })
    }
    
    func deleteAppointment(appointment: Appointment, completion: @escaping(Result<Bool, AppointmentsError>) -> Void ){
    }
    
    func getAppointment(appointment:Appointment ,completion: @escaping(Result<Appointment, AppointmentsError>) -> Void){
    }
    
    func changeAppointment(old:Appointment , new: Appointment, completion: @escaping(Result<Bool, AppointmentsError>) -> Void){
        
    }
}
