//
//  RequestFactory.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 1.3.22..
//

import Foundation

class RequestFactory {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }
    
    static func makeRequest(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], body: Data? = nil) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "medicinecarton-f12ab-default-rtdb.firebaseio.com"
        components.path = path
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
