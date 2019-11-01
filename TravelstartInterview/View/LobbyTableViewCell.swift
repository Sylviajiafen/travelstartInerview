//
//  LobbyTableViewCell.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/1.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

protocol LobbyTableViewCellDelegate: AnyObject,
UICollectionViewDelegate, UICollectionViewDataSource {
    
}

class LobbyTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var placeDescription: UITextView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        
        didSet {
            
            imageCollectionView.delegate = self.delegate
            
            imageCollectionView.dataSource = self.delegate
        }
    }
    
    weak var delegate: LobbyTableViewCellDelegate? {
        
        didSet {
            
            guard let collectionView = imageCollectionView else { return }
            
            collectionView.delegate = self.delegate
            
            collectionView.dataSource = self.delegate
        }
    }
    
    func layout(by data: Results) {
        
        title.text = data.title
        
        placeDescription.text = data.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
