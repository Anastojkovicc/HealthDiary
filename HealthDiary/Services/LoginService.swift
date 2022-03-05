//
//  LoginService.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation
import Alamofire

enum LoginError: Error {
    case invalidParametars
    case noUser
}

class LoginService {
    
    func login(email: String, password: String, completion: @escaping(Result<User, LoginError>) -> Void){
        let request = RequestFactory.makeRequest(method: .get,
                                                 path: "/healthDiary/users.json",
                                                 queryItems: [
                                                    URLQueryItem(name: "orderBy", value: "\"email\""),
                                                    URLQueryItem(name: "equalTo", value: "\"\(email)\""),
                                                ])
        AF.request(request)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(user))
                    } catch {
                        completion(.failure(.noUser))
                    }
                case .failure:
                    completion(.failure(.invalidParametars))
                }
            })
            .cURLDescription(calling: { description in
                print(description)
            })
    }
}
