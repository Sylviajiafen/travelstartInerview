//
//  DetailViewController.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailView: DetailView! {
        
        didSet {
            
            print("放了 ｄｅｌｅｇａｔｅ")
            
            detailView.delegate = self
            
        }
    }
    
    var data: Results? {
        
        didSet {
            
            print("data: \(data)")
            
            guard let data = data else { return }
            
            cellData = FileSeparator.shared.detailCellData(from: data)
        }
    }
    
    var cellData = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DetailViewController: DetailViewDelegate {
    
    func setUpHeader(_ view: DetailView) {
        
//        view.headerImageScrollView.frame.size.height = screenSize.width * 0.6
    }
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int
    ) -> Int {
        
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self), for: indexPath)
        
        guard let detailCell = cell as? DetailTableViewCell else { return cell }
        
//        if let detailData = data {
//
//            print("index: \(indexPath.row)")
//
//            detailCell.layout(at: indexPath.row, by: detailData)
//        }
        
        detailCell.layout(by: cellData[indexPath.row])
        
        return detailCell
    }

}
