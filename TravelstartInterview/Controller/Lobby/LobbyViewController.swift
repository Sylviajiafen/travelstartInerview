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

    private func checkConnection(result: @escaping (Bool) -> Void) {
        
        let networkHelper = NetworkHelper()

        networkHelper.startMonitor { [weak self] connection in

            switch connection {

            case .connected:

                print("connected")
                
                result(true)

            case .unconnected:

                print(connection.rawValue)
                
                self?.showAlertOfNetworkIssue()

                result(false)
            }
            
            networkHelper.stopMonitor()
        }
    }
    
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
            
            destination.data = data
        }
    }
    
    private struct Segue {
        
        static let detail = "showDetail"
    }
}

extension LobbyViewController: LobbyViewDelegate {
    
    var hasFetched: Bool {
        
        if datas.count == 0 {
            
            return false
            
        } else {
            
            return true
        }
    }
    
    func triggerRefresh(_ view: LobbyView) {
        
        checkConnection { [weak self] (isConnected) in
            
            if isConnected {
                
                self?.fetchData { isTheEnd in
                        
                    if !isTheEnd {
                            
                        view.addFooterRefresh()
                            
                    } else {
                          
                        view.endWithNoMoreData()
                    }
                }

            } else {
                
                view.addFooterRefresh()
            }
        }
    }
    
    func loadMoreData(_ view: LobbyView) {
        
        checkConnection { [weak self] isConnected in
            
            if isConnected {
                
                HTTPClient.shared.loadNext()
                           
                self?.fetchData { isTheEnd in
                               
                    if !isTheEnd {
                                   
                        view.endFooterRefreshing()
                                   
                    } else {
                                   
                        view.endWithNoMoreData()
                    }
                }
                
            } else {
                
                view.endFooterRefreshing()
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
