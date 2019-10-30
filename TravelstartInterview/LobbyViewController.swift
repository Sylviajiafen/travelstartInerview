//
//  LobbyViewController.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = HTTPRequest(scheme: "https",
                                  host: "data.taipei",
                                  path: "/datalist/apiAccess",
                                  queryItems: [
                                    URLQueryItem(name: "scope", value: "resourceAquire"),
                                    URLQueryItem(name: "rid", value: "36847f3f-deff-4183-a5bb-800737591de5")])
        
        HTTPClient.shared.request(request) { (result) in
            <#code#>
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
