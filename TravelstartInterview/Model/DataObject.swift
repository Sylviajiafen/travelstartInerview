//
//  DataObject.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/1.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

struct FetchResults: Codable {
    
    let result: FetchResult
}

struct FetchResult: Codable {
    
    let count: Int
    
    let results: [Results]
}

struct Results: Codable {
    
    let info: String?
    
    let title: String
    
    let description: String
    
    let address: String
    
    let file: String
    
    let mrt: String?
    
    let time: String?
    
    enum CodingKeys: String, CodingKey {
        
        case info
        
        case title = "stitle"
        
        case description = "xbody"
        
        case address
        
        case file
        
        case mrt = "MRT"
        
        case time = "MEMO_TIME"
    }
}
