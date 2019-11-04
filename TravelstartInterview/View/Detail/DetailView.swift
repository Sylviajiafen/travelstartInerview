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
    
    func setUpPageControl(_ view: DetailView)
}

class DetailView: UIView {

    @IBOutlet weak var detailTableView: UITableView! {
        
        didSet {
            
            detailTableView.delegate = self.delegate
            
            detailTableView.dataSource = self.delegate
            
            detailTableView.reloadData()
            
        }
    }
    
    @IBOutlet weak var headerScrollView: UIScrollView! {
        
        didSet {
            
            headerScrollView.delegate = self.delegate
            
            self.delegate?.setUpHeader(self)
            
            setPageControlPosition()
            
            self.delegate?.setUpPageControl(self)
        }
    }
        
    var pageControl = UIPageControl() {
        
        didSet {
            
            print("pageControl didSet")
        }
    }
    
    private func setPageControlPosition()  {
        
        detailTableView.addSubview(pageControl)
        
        detailTableView.bringSubviewToFront(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.bottomAnchor.constraint(
            equalTo: headerScrollView.bottomAnchor).isActive = true
        
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        pageControl.currentPageIndicatorTintColor =
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        pageControl.pageIndicatorTintColor =
            UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 0.5)
        
        pageControl.addTarget(self, action: #selector(switchPage), for: .valueChanged)
    }
    
    @objc func switchPage(_ sender: UIPageControl) {
        
        let currentPageNum = sender.currentPage
        
        let width = headerScrollView.frame.size.width
        
        let currentPageXPosition = width * CGFloat(currentPageNum)
        
        let offset = CGPoint(x: currentPageXPosition, y: 0)
        
        headerScrollView.setContentOffset(offset, animated: true)
    }
    
    weak var delegate: DetailViewDelegate? {
        
        didSet {
                        
            guard let tableView = detailTableView else { return }

            tableView.dataSource = self.delegate

            tableView.delegate = self.delegate

            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
