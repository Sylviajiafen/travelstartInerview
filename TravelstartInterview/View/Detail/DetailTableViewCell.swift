//
//  DetailTableViewCell.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/3.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UITextView!
    
    let titles: [String] = ["景點名稱", "景點介紹", "景點位置", "交通資訊", "附近捷運", "開放時間"]
    
    func layout(by data: CellData) {
        
        title.text = data.title
        
        content.text = data.content
    }
    
    func layout(at index: Int, by data: Results) {
        
        print(index)
        
        title.text = titles[index]
        
        switch index {
            
        case 0:
            
            content.text = data.title
            
        case 1:
            
            content.text = data.description
            
        case 2:
            
            content.text = data.address
            
        case 3:
            
            content.text = data.info ?? ""
            
        case 4:
            
            content.text = data.mrt ?? ""
            
        case 5:
            
            content.text = data.time ?? ""
    
        default:
            break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


