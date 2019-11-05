//
//  NetworkHelper.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/5.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation
import Network

class NetworkHelper {
    
    private let monitor = NWPathMonitor()
    
    func startMonitor(handler: @escaping (ConnectionStatus) -> Void) {
        
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                
                handler(.connected)
                
             } else if path.status == .unsatisfied {
                
                handler(.unconnected)
             }
        }
     
        monitor.start(queue: DispatchQueue.global())
    }
    
    func stopMonitor()  {
        
        monitor.cancel()
    }
}

enum ConnectionStatus: String {
    
    case connected
    
    case unconnected = "未連接到網路"
    
}
