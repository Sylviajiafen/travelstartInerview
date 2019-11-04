//
//  DetailViewController.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/10/30.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailView: DetailView! {
        
        didSet {
            
            print("放了 ｄｅｌｅｇａｔｅ")
            
            detailView.delegate = self
            
        }
    }
    
    var data: Results? {
        
        didSet {
            
            print("data: \(data)")
            
            guard let data = data else { return }
            
            cellData = FileSeparator.shared.detailCellData(from: data)
            
            imageData = FileSeparator.shared.filterImage(data.file)
        }
    }
    
    var cellData = [CellData]()
    
    var imageData = [String]() {
        
        didSet {
            
            print("image 好了: \(imageData)")
            
            showImage?()
        }
    }
    
    var showImage: (() -> Void)?
    
    func setImageOn(_ scrollView: UIScrollView) {
        
        for index in imageData.indices {
            
            let scrollImage = UIImageView()
            
            scrollImage.frame =
                CGRect(x: screenSize.width * CGFloat(index),
                       y: 0,
                       width: screenSize.width,
                       height: screenSize.width * 0.6)
            
            scrollImage.loadImage(imageData[index])
            
            scrollImage.contentMode = .scaleAspectFill
            
            scrollImage.clipsToBounds = true
            
            print("scrollView: \(scrollView)")
            
            print("image: \(scrollImage)")
            
            scrollView.addSubview(scrollImage)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DetailViewController: DetailViewDelegate {
    
    func setUpHeader(_ view: DetailView) {
        
        view.headerScrollView.bounds.size.width = screenSize.width
        
        view.headerScrollView.bounds.size.height = screenSize.width * 0.6 + 9
        
        showImage = { [weak self] in
            
            guard let strongSelf = self else { return }
            
            let scrollWidth = strongSelf.screenSize.width * CGFloat(strongSelf.imageData.count)
            
            view.headerScrollView.contentSize =
                CGSize(width: scrollWidth,
                       height: strongSelf.screenSize.width * 0.6 + 9)
            
            strongSelf.setImageOn(view.headerScrollView)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int
    ) -> Int {
        
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self), for: indexPath)
        
        guard let detailCell = cell as? DetailTableViewCell else { return cell }
        
        detailCell.layout(by: cellData[indexPath.row])
        
        return detailCell
    }

}
