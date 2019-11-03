//
//  KingFisherWrapper.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/2.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func loadImage(_ urlString: String, placeHolder: UIImage? = nil) {
        
        let url = URL(string: urlString)
        
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
