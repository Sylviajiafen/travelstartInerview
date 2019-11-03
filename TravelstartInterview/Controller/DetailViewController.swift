//
//  DetailViewController.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data: Results? {
        
        didSet {
            
            print("Data: \(data)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
