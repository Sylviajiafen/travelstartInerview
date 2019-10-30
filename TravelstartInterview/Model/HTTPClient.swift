//
//  HTTPClient.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

enum HTTPRequestError: Error {
    
    case decodeDataError
    
    case serverError
    
    case clientError
    
    case unexpectedError
}

struct HTTPRequest {
    
    var scheme: String
    
    var host: String
    
    var path: String
    
    var queryItems: [URLQueryItem]
    
    func makeRequest() -> URLRequest? {
        
        var urlComponents = URLComponents()
            
        urlComponents.scheme = scheme
            
        urlComponents.host = host
            
        urlComponents.path = path
            
        urlComponents.queryItems = queryItems
            
    //        urlComponents.scheme = "https"
            
    //        urlComponents.host = "data.taipei"
            
    //        urlComponents.path = "/datalist/apiAccess"
            
    //        urlComponents.queryItems = [
            
    //            URLQueryItem(name: "scope", value: "resourceAquire"),
                
    //            URLQueryItem(name: "rid", value: "36847f3f-deff-4183-a5bb-800737591de5")
    //        ]
            
        guard let url = urlComponents.url else { return nil }
            
        return URLRequest(url: url)
    }
    
}

class HTTPClient {
    
    static let shared = HTTPClient()
    
    private init() { }
    
    func request(_ httpRequest: HTTPRequest,
                 completion: @escaping (Result<Data, HTTPRequestError>) -> Void) {
        
        guard let request = httpRequest.makeRequest() else { return }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
                guard error == nil else {
                
                    completion(.failure(.unexpectedError))
                    
                    return
                }
            
                if let response = response as? HTTPURLResponse {
                
                    let statusCode = response.statusCode
                
                    switch statusCode {
                    
                    case 200..<300 :
                
                        guard let data = data else { return }
                    
                        completion(.success(data))
                    
                    case 400..<500:
                    
                        completion(.failure(.clientError))
                    
                    case 500..<600:
                    
                        completion(.failure(.serverError))
                    
                    default: return
                }
            }
        }
        
        task.resume()
    }
    
}
