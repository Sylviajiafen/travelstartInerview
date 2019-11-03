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
    
    func loadMoreData(_ view: LobbyView)
}

class LobbyView: UIView {
    
    @IBOutlet weak var lobbyTableView: UITableView! {
        
        didSet {
            
            lobbyTableView.delegate = self.delegate
            
            lobbyTableView.dataSource = self.delegate
        }
    }
        
    weak var delegate: LobbyViewDelegate? {
        
        didSet {
            
            guard let tableView = lobbyTableView else { return }
            
            tableView.delegate = self.delegate
            
            tableView.dataSource = self.delegate
            
            self.delegate?.triggerRefresh(self)
            
            setUpTableView()
        }
    }
    
    func reloadData() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.lobbyTableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        
        lobbyTableView.addRefreshFooter { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.delegate?.loadMoreData(strongSelf)
        }
    }
    
    func endFooterRefreshing() {
        
        lobbyTableView.endFooterRefreshing()
    }
    
    func endWithNoMoreData() {
        
        lobbyTableView.endWithNoMoreData()
    }

}
