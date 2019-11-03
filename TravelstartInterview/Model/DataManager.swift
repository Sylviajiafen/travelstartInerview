//
//  DataManager.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

enum FetchError: Error {
    
    case decodeError
    
    case cannotFetch
}

class DataManager {
    
    static let shared = DataManager()
    
    static var dataTotal: Int = 1
    
    private init() {}

    func fetchData(completion: @escaping ((Result<FetchResults, FetchError>) -> Void)) {
        
        HTTPClient.shared.request(HTTPClient.travelTaipei) { (result) in
            
            switch result {
                
            case .success(let data):
               
                do {
                    
                    let dataObject = try JSONDecoder().decode(FetchResults.self, from: data)
                    
                    DataManager.dataTotal = dataObject.result.count
                    
                    print("加好：total Count: \(DataManager.dataTotal)")
                    
                    completion(.success(dataObject))
                    
                } catch {
                    
                    completion(.failure(.decodeError))
                    print("DECODE ERR")
                    print(error)
                }
                
                
            case .failure( _):
                
                completion(.failure(.cannotFetch))
                
                print("CANNOT FETCH")
            }
        }
    }
}
