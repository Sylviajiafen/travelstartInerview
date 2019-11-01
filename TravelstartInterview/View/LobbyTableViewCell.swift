//
//  LobbyTableViewCell.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/1.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class LobbyTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var placeDescription: UITextView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var imageData = [String]() {
        
        didSet {
            
            print("=========check image url: \(imageData.count)========")
            
            print(imageData)
        }
    }
    
    func layout(by data: Results) {
        
        title.text = data.title
        
        placeDescription.text = data.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCollectionView.dataSource = self
        
        imageCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension LobbyTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath)
        
        guard let imageItem = item as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        print("====image data=====")
        print(imageData[indexPath.row])
        
        imageItem.layout(by: imageData[indexPath.row])
        
        return imageItem
    }
    
}

extension LobbyTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.size
        
        let width = (screenSize.width - 26) / 2.0
        
        let height = width / 1.5
        
        return CGSize(width: width, height: height)
    }
}
