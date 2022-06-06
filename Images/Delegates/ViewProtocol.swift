//
//  ViewProtocol.swift
//  Images
//
//  Created by Alice Romanova on 03.06.2022.
//

import Foundation


protocol ViewProtocol {
    
    func selectURL(url: PictureParametets)
    
    func displayData(data: [PictureParametets])
}
