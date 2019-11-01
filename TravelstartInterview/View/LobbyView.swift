//
//  LobbyView.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/1.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

protocol LobbyViewDelegate: AnyObject, UITableViewDelegate, UITableViewDataSource {
    
    func triggerRefresh(_ view: LobbyView)
}

class LobbyView: UIView {
    
    @IBOutlet weak var lobbyTableView: UITableView!
        
    weak var delegate: LobbyViewDelegate? {
        
        didSet {
            
            guard let tableView = lobbyTableView else { return }
            
            tableView.delegate = self.delegate
            
            tableView.dataSource = self.delegate
            
            self.delegate?.triggerRefresh(self)
        }
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
   }
    
    func reloadData() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.lobbyTableView.reloadData()
        }
    }

}
