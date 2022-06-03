//
//  SearchResaults.swift
//  Images
//
//  Created by Alice Romanova on 20.05.2022.
//

import Foundation


struct SearchResaults: Decodable {
    
    let width: Int
    let height: Int
    let urls: [URLType.RawValue:String]
    
    enum URLType: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
