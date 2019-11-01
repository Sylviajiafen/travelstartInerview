//
//  LobbyView.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/1.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

protocol LobbyViewDelegate: AnyObject, UITableViewDelegate, UITableViewDataSource {
    
    
}

class LobbyView: UIView {
    
    @IBOutlet weak var lobbyTableView: UITableView! {
        
        didSet {
            
            lobbyTableView.delegate = self.delegate
            
            lobbyTableView.dataSource = self.delegate
        }
    }
    
    weak var delegate: LobbyViewDelegate?
    
    override func awakeFromNib() {
       super.awakeFromNib()
   
   }
    
    func reloadData() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.lobbyTableView.reloadData()
        }
    }

}
