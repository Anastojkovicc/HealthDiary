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
        components.scheme = "http"
        components.host = "bf91-87-116-190-81.ngrok.io"
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.headers.add(name: "Content-Type", value: "application/json")
        return request
    }
}
