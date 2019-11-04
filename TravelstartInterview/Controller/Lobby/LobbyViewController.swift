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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = "台北市熱門景點"
    }
    
    var datas = [Results]() {
        
        didSet {
            
            lobbyView.reloadData()
        }
    }
    
    var data: Results?
    
    var currentTitle: String = ""
    
    func fetchData(isTheEnd: @escaping ((Bool) -> Void)) {
        
        if datas.count < DataManager.dataTotal {
            
            DataManager.shared.fetchData { [weak self] (result) in
                
                switch result {
                    
                case .success(let result):
                    
                    self?.datas.append(contentsOf: result.result.results)
                    
                case .failure(let error):
               
                    print(error.localizedDescription)
                }
                    
                isTheEnd(false)
            }
            
        } else {
            
            isTheEnd(true)
            
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == Segue.detail {

            guard let destination = segue.destination
                as? DetailViewController else { return }
            
            destination.navigationItem.title = currentTitle
            
            destination.view.layoutIfNeeded()
            
            destination.data = data
        }
    }
    
    private struct Segue {
        
        static let detail = "showDetail"
    }
}

extension LobbyViewController: LobbyViewDelegate {
    
    func triggerRefresh(_ view: LobbyView) {

        fetchData { isTheEnd in
            
            if !isTheEnd {
                
                view.addFooterRefresh()
                
            } else {
              
                view.endWithNoMoreData()
            }
        }
    }
    
    func loadMoreData(_ view: LobbyView) {
        
        HTTPClient.shared.loadNext()
        
        fetchData { isTheEnd in
            
            if !isTheEnd {
                
                view.endFooterRefreshing()
                
            } else {
                
                view.endWithNoMoreData()
            }
        }
    }
       
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int
    ) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LobbyTableViewCell.self), for: indexPath)
        
        guard let lobbyCell = cell as? LobbyTableViewCell else { return cell }
        
        lobbyCell.layout(by: datas[indexPath.row])
        
        lobbyCell.imageData = FileSeparator.shared.filterImage(datas[indexPath.row].file)
        
        lobbyCell.segueTrigger = { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.currentTitle = strongSelf.datas[indexPath.row].title
            
            strongSelf.data = strongSelf.datas[indexPath.row]
            
            strongSelf.performSegue(withIdentifier: Segue.detail, sender: nil)
        }
        
        return lobbyCell
    }
    
}
