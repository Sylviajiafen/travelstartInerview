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
    
    func showAlertOfNetworkIssue() {
        
        let alert = UIAlertController(title: "無法連線", message: "請確認網路狀態", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(action)
        
        DispatchQueue.main.async { [weak self] in
            
            self?.present(alert, animated: true, completion: nil)
        }
        
    }
}
