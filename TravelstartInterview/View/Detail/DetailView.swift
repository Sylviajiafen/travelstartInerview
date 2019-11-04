//
//  DetailView.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/3.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

protocol DetailViewDelegate: AnyObject, UITableViewDataSource, UITableViewDelegate {
    
    func setUpHeader(_ view: DetailView)
}

class DetailView: UIView {

    @IBOutlet weak var detailTableView: UITableView! {
        
        didSet {
            
            print("做好 tableView")
            
            detailTableView.delegate = self.delegate
            
            detailTableView.dataSource = self.delegate
            
            detailTableView.reloadData()
        }
    }
    
    @IBOutlet weak var headerScrollView: UIScrollView! {
        
        didSet {
            
            print("做好 header: \(headerScrollView)")
            
            headerScrollView.delegate = self.delegate
            
            self.delegate?.setUpHeader(self)
        }
    }
    

    
    weak var delegate: DetailViewDelegate? {
        
        didSet {
            
            guard let tableView = detailTableView else { return }
            
            tableView.dataSource = self.delegate
            
            tableView.delegate = self.delegate
            
            tableView.reloadData()
            
        }
    }
    
    func reloadData() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.detailTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
