//
//  SignUpService.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation
import Alamofire

enum SignUpError: Error {
    case invalidParametars
}

class SignUpService {
    
    func signUp(registrationData: RegistrationData, completion: @escaping (Result<User, SignUpError>) -> Void) {
        let userBody = try! JSONEncoder().encode(registrationData)
        let request = RequestFactory.makeRequest(method: .post,
                                                 path: "/healthDiary/users.json",
                                                 body: userBody)
        AF.request(request)
            .responseDecodable(of: FirebaseAutoID.self) { response in
                switch response.result {
                case .success(let autoID):
                    let user = User(id: autoID.name, firstName: registrationData.firstName, lastName: registrationData.lastName, email: registrationData.email, password: registrationData.password)
                    completion(.success(user))
                case .failure:
                    completion(.failure(.invalidParametars))
                }
            
        }
    }
}
