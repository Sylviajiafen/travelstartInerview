//
//  MJRefreshWrapper.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/2.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation
import MJRefresh

extension UITableView {
    
    func addRefreshFooter(refreshingBlock: @escaping () -> Void) {

        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: refreshingBlock)
    }
    
    func endFooterRefreshing() {

        mj_footer.endRefreshing()
    }

    func endWithNoMoreData() {

        mj_footer.endRefreshingWithNoMoreData()
    }

    func resetNoMoreData() {

        mj_footer.resetNoMoreData()
    }
}
