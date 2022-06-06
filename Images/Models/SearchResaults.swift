//
//  SearchResaults.swift
//  Images
//
//  Created by Alice Romanova on 20.05.2022.
//

import Foundation


struct SearchResults: Decodable {
    let total: Int
    let results: [PictureParametets]
}

struct PictureParametets: Decodable {
    
    let urls: [URLType.RawValue:String]
    
    
    enum URLType: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
