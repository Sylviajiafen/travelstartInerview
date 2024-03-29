//
//  HTTPClient.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

enum HTTPRequestError: Error {

    case serverError(Int)
    
    case clientError(Int)
    
    case unexpectedError
}

struct HTTPRequest {
    
    var scheme: String
    
    var host: String
    
    var path: String
    
    var queryItems: [URLQueryItem]
    
    init(offset: String) {
        
        scheme = "https"
            
        host = Bundle.valueForString(BundleKeys.host)
            
        path = Bundle.valueForString(BundleKeys.path)
        
        queryItems = [
            URLQueryItem(name: QueryParameter.scope,
                         value: Bundle.valueForString(BundleKeys.scope)),
            URLQueryItem(name: QueryParameter.rid,
                         value: Bundle.valueForString(BundleKeys.rid)),
            URLQueryItem(name: QueryParameter.limit,
                         value: "10"),
            URLQueryItem(name: QueryParameter.offset,
                         value: offset)
        ]
    }
    
    func makeRequest() -> URLRequest? {
        
        var urlComponents = URLComponents()
            
        urlComponents.scheme = scheme
            
        urlComponents.host = host
            
        urlComponents.path = path
            
        urlComponents.queryItems = queryItems
            
        guard let url = urlComponents.url else { return nil }
        
        return URLRequest(url: url)
    }
}

struct QueryParameter {
    
    static let scope: String = "scope"
    
    static let rid: String = "rid"
    
    static let limit: String = "limit"
    
    static let offset: String = "offset"
}

class HTTPClient {
    
    static let shared = HTTPClient()
    
    private init() { }
    
    private var offset = 0
    
    func loadNext() {
        
        offset += 10
    }
    
    static var travelTaipei: HTTPRequest {
        
        let offset = String(HTTPClient.shared.offset)
        
        return HTTPRequest(offset: offset)
    }

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
                    
                        completion(.failure(.clientError(statusCode)))
                    
                    case 500..<600:
                    
                        completion(.failure(.serverError(statusCode)))
                    
                    default: return
                }
            }
        }
        
        task.resume()
    }
    
}
