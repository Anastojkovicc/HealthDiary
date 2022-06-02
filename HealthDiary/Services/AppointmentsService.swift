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
    
    func deleteAppointment(appointment: AppointmentShort, completion: @escaping(Result<Void, AppointmentsError>) -> Void ){
        let request = RequestFactory.makeRequest(method: .delete,
                                                 path: "/appointments/\(appointment.id)")
        
        AF.request(request).responseData(completionHandler: { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                debugPrint(error)
                completion(.failure(.invalidParametars))
            }
        }).cURLDescription(calling: { description in
            print(description)
        })

                                                 
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
    
    func updateAppointment(_ appointment: Appointment, completion: @escaping(Result<Void, AppointmentsError>) -> Void){
        let medications = appointment.medications.map({ med in
            return NewMedication(name: med.name, consumption: med.consumption)
        })
        let savingAppointment = NewAppointmentData.init(type: appointment.type, date: appointment.date, note: appointment.note, userId: DataStorage.shared.loggedUser!.id , medications: medications)
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let appointmentBody = try! encoder.encode(savingAppointment)
        let request = RequestFactory.makeRequest(method: .put,
                                                 path: "/appointments/\(appointment.id)",
                                                body: appointmentBody)
            AF.request(request)
                .responseData(completionHandler: { response in
                    switch response.result {
                    case .success:
                        completion(.success(()))
                        
                    case .failure:
                        completion(.failure(.invalidParametars))
                    }
                    
                }).cURLDescription(calling: { description in
                    print(description)
                })
        
    }
}
