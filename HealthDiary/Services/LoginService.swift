//
//  LoginService.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation
import Alamofire

class LoginService {
    
    func login(email: String, password: String, completion: @escaping(Result<User, LoginError>) -> Void){
        let loginData = LoginData.init(email: email, password: password)
        let loginBody = try! JSONEncoder().encode(loginData)
        let request = RequestFactory.makeRequest(method: .post,
                                                 path: "/login",
                                                 body: loginBody)
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
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(.invalidParametars))
                }
            })
    }
}
