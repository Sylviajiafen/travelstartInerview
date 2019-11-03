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

class DetailView: UIView, UIScrollViewDelegate {

    @IBOutlet weak var detailTableView: UITableView! {
        
        didSet {
            
            print("做好 tableView")
            
            detailTableView.delegate = self.delegate
            
            detailTableView.dataSource = self.delegate
            
            detailTableView.reloadData()
        }
    }
    
//    @IBOutlet weak var headerImageScrollView: UIScrollView! {
//
//        didSet {
//
//            print("做好 header")
//
//            headerImageScrollView.delegate = self
//
//            setUpScrollView()
//        }
//    }
    
    weak var delegate: DetailViewDelegate? {
        
        didSet {
            
            print("進 ｄｅｌｅｇａｔｅ didSet")
            
            guard let tableView = detailTableView
//                ,
//                let scrollView = headerImageScrollView
                else {
                    print("找不到")
                    return }
            
            tableView.dataSource = self.delegate
            
            tableView.delegate = self.delegate
            
            print("找到 ｄｅｌｅｇａｔｅ")
            
            tableView.reloadData()
            
//            scrollView.delegate = self.delegate
        }
    }
    
    func reloadData() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.detailTableView.reloadData()
        }
    }
    
    private func setUpScrollView() {
        
        let screenWidth = UIScreen.main.bounds.size.width
        
//        headerImageScrollView.frame.size.height = screenWidth * 0.6
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
