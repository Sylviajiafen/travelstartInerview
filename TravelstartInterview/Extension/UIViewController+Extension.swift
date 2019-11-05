//
//  UIViewController+Extension.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/3.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

extension UIViewController {
    
    open var screenSize: CGSize { return UIScreen.main.bounds.size }
    
    func showAlertOf(issue: AlertIssue, title: AlertTitle, addition: String? = nil) {
        
        DispatchQueue.main.async { [weak self] in
            
            let message = issue.rawValue + (addition ?? "")
            
            let alert = UIAlertController(title: title.rawValue,
                                          message: message,
                                          preferredStyle: .alert)
        
            let action = UIAlertAction(title: "OK", style: .cancel)
        
            alert.addAction(action)
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

enum AlertIssue: String {
    
    case notConnected = "請確認網路狀態"
    
    case fetchDataError = "下載資料時發生了問題"
}

enum AlertTitle: String {
    
    case notConnected = "無法連線"
    
    case fetchDataError = "失敗"
}
