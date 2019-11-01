//
//  LobbyViewController.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    @IBOutlet var LobbyView: LobbyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.shared.fetchData { (result) in
            
            switch result {
                
            case .success(let result):
                
                print("======DATA==========")
                print(result.result.results[0].info)
                print(result.result.results[0].title)
                print(result.result.results[0].description)
                
            case .failure(let error):
                
                print("=====ERROR!!!======")
                print(error.localizedDescription)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
