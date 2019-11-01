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
    
    func reorder(_ string: String) -> [String] {
        
        let separatedUrls = string.components(separatedBy: separatorCharacter)
        
        let reorderedUrls: [String] = separatedUrls.compactMap { [weak self] (url) -> String? in
               
            if url.contains("jpg") || url.contains("JPG") {
                   
                guard let strongSelf = self else { return nil }
                
                return strongSelf.separatorCharacter + url
                   
            } else {
                   
                return nil
            }
        }
           
        return reorderedUrls
    }
}
