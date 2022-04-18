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
    
    func getAppointmentsList(user: User, completion: @escaping(Result<[AppointmentShort], AppointmentsError>) -> Void){
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
                        let appointments = try decoder.decode([AppointmentShort].self, from: data)
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
    
    func deleteAppointment(appointment: AppointmentShort, completion: @escaping(Result<Bool, AppointmentsError>) -> Void ){
    }
    
    //TODO: pass appointment and user Id instead of whole objects
    func getAppointment(user: User, appointment:AppointmentShort ,completion: @escaping(Result<Appointment, AppointmentsError>) -> Void){
            let request = RequestFactory.makeRequest(method: .get,
                                                     path: "/appointments/\(appointment.id)",
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
                            
                            let appointment = try decoder.decode(Appointment.self, from: data)
                            completion(.success(appointment))
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
    
    func changeAppointment(old:Appointment , new: Appointment, completion: @escaping(Result<Bool, AppointmentsError>) -> Void){
        
    }
}
