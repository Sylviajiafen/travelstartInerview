//
//  LobbyViewController.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    @IBOutlet var lobbyView: LobbyView! {
        
        didSet {
            
            lobbyView.delegate = self
        }
    }
    
    var datas = [Results]() {
        
        didSet {
            
            lobbyView.reloadData()
        }
    }
    
    var currentTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchData() {
        
        DataManager.shared.fetchData { [weak self] (result) in
            
            switch result {
                
            case .success(let result):
                
                print("======DATA==========")
                print(result.result.results[0].info)
                print(result.result.results[0].title)
                print(result.result.results[0].description)
                print(result.result.results[0].file)
                
                self?.datas = result.result.results
                
            case .failure(let error):
                
                print("=====ERROR!!!======")
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == Segue.detail {

            guard let destination = segue.destination
                as? DetailViewController else { return }
            
            destination.navigationItem.title = currentTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = "台北市熱門景點"
    }
    
    private struct Segue {
        
        static let detail = "showDetail"
    }
}

extension LobbyViewController: LobbyViewDelegate {
    
    func triggerRefresh(_ view: LobbyView) {
        
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LobbyTableViewCell.self), for: indexPath)
        
        guard let lobbyCell = cell as? LobbyTableViewCell else { return cell }
        
        lobbyCell.layout(by: datas[indexPath.row])
        
        lobbyCell.imageData = FileSeparator.shared.reorder(datas[indexPath.row].file)
        
        lobbyCell.segueTrigger = { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.currentTitle = strongSelf.datas[indexPath.row].title
            
            strongSelf.performSegue(withIdentifier: Segue.detail, sender: nil)
        }
        
        return lobbyCell
    }
    
}
