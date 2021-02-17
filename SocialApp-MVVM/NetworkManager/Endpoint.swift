//
//  EndPoint.swift
//  SocialApp
//
//  Created by Oleksandr Bretsko on 1/2/21.
//

import Foundation


enum EndPoint: String {
    
    case posts
    case users
    case comments
    
    private static let baseURL = "jsonplaceholder.typicode.com"
    
    func makeURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Self.baseURL
        components.path = "/" + rawValue
        return components.url!
    }
    
    func makeURLRequest() -> URLRequest {
        let url = makeURL()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
