//
//  SignUpService.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation
import Alamofire

class SignUpService {
    
    func signUp(registrationData: RegistrationData, completion: @escaping (Result<User, SignUpError>) -> Void) {
        let userBody = try! JSONEncoder().encode(registrationData)
        let request = RequestFactory.makeRequest(method: .post,
                                                 path: "/register",
                                                 body: userBody)
        AF.request(request)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(user))
                    } catch {
                        completion(.failure(.invalidParametars))
                    }
                case .failure:
                    completion(.failure(.invalidParametars))
                }
            
            })
    }
}
