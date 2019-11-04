//
//  ReachabilityHelper.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/4.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

class ReachabilityHelper {
    
    static let shared = ReachabilityHelper()
    
//    let reachability = try? Reachability()
//
//    func checkNetWork() {
//
//        do {
//            try reachability?.startNotifier()
//
//        } catch {
//
//            print("ERROR OF START reachability")
//        }
//
//        reachability?.whenReachable = { [weak self] reachability in
//
//            switch reachability.connection {
//
//            case .wifi:
//
//                print("Reachable via WiFi")
//                self?.reachability?.stopNotifier()
//
//            case .cellular:
//
//                print("Reachable via Cellular")
//                self?.reachability?.stopNotifier()
//
//            case .none:
//
//                print("NO CONNECTION")
//                self?.reachability?.stopNotifier()
//
//            default:
//
//                break
//            }
//
//        }
//    }
    
    private init() { }
    
}
