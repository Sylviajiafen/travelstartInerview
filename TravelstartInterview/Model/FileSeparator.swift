//
//  FileSeperator.swift
//  TravelstartInterview
//
//  Created by Sylvia Jia Fen  on 2019/11/2.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import Foundation

class FileSeparator {
    
    static let shared = FileSeparator()
    
    private init() {}
    
    private let separatorCharacter: String = "http://"
    
    func filterImage(_ string: String) -> [String] {
        
        let separatedUrls = string.components(separatedBy: separatorCharacter)
        
        let filteredUrls: [String] = separatedUrls.compactMap { [weak self] url -> String? in
               
            if url.contains(".jpg") || url.contains(".JPG") || url.contains(".png"){
                   
                guard let strongSelf = self else { return nil }
                
                return strongSelf.separatorCharacter + url
                   
            } else {
                   
                return nil
            }
        }
           
        return filteredUrls
    }
    
    func detailCellData(from data: Results) -> [CellData] {
        
        var dataArr = [CellData]()
        
        dataArr.append(CellData(title: "景點名稱", content: data.title))
        
        dataArr.append(CellData(title: "景點介紹", content: data.description))
        
        dataArr.append(CellData(title: "景點位置", content: data.address))
        
        dataArr.append(CellData(title: "交通資訊", content: data.info ?? "無資訊"))
        
        dataArr.append(CellData(title: "附近捷運", content: data.mrt ?? "無資訊"))
        
        dataArr.append(CellData(title: "開放時間", content: data.time ?? "無資訊"))
        
        return dataArr
    }
}

struct CellData {
    
    let title: String
    
    let content: String
}
