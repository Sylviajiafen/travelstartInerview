//
//  Bundle+Extension.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/1.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

struct BundleKeys {
    
    static let host: String = "TaipeiTravelHost"
    
    static let path: String = "TaipeiTravelPath"
    
    static let scope: String = "TaipeiTravelQueryScope"
    
    static let rid: String = "TaipeiTravelQueryRid"
}


extension Bundle {
    
    static func valueForString(_ key: String) -> String {
        
        guard let value = Bundle.main.infoDictionary?[key] as? String else { return "" }
        
        return value
    }
}
