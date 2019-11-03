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
    
    var data: Results?
    
    var currentTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchData(isTheEnd: ((Bool) -> Void)?) {
        
        if datas.count < DataManager.dataTotal {
            
            DataManager.shared.fetchData { [weak self] (result) in
                
                switch result {
                    
                case .success(let result):
                    
                    self?.datas.append(contentsOf: result.result.results)
                    
                    print("加好了：畫面 data count：\(self?.datas.count)")
                    
                case .failure(let error):
               
                    print(error.localizedDescription)
                }
                
                print("加好後進 handler: not the end")
                print("\(self?.datas.count) datas: \(self?.datas)")
                    
                isTheEnd?(false)
            }
            
        } else {
            
            print("未進加好： the end")
            
            isTheEnd?(true)
            
            return
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == Segue.detail {

            guard let destination = segue.destination
                as? DetailViewController else { return }
            
            destination.navigationItem.title = currentTitle
            
            destination.data = data
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
        
        fetchData(isTheEnd: nil)
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
            
            strongSelf.data = strongSelf.datas[indexPath.row]
            
            strongSelf.performSegue(withIdentifier: Segue.detail, sender: nil)
        }
        
        return lobbyCell
    }
    
}
