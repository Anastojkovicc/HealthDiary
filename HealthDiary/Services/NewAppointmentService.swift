//
//  NewAppointmentService.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation
import Alamofire

class NewAppointmentService {
    
    func saveAppointment(newAppointment: NewAppointmentData, medications: [NewMedication], completion: @escaping(Result<Void, NewAppointmentError>) -> Void){
        print(newAppointment.userId)
        let savingAppointment = NewAppointmentData.init(type: newAppointment.type, date: newAppointment.date, note: newAppointment.note, userId: newAppointment.userId, medications: medications)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let appointmentBody = try! encoder.encode(savingAppointment)
        let request = RequestFactory.makeRequest(method: .post,
                                                 path: "/appointments",
                                                 body: appointmentBody)
        AF.request(request)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    completion(.success(()))
                    
                case .failure:
                    completion(.failure(.invalidParametars))
                }
                
            }).cURLDescription(calling: { description in
                print(description)
            })
    }
}
