//
//  MBAResponse.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/26/22.
//

import Foundation


struct MBAResponse<T: Codable>: Codable {
    
    let code: Int
    let message: String
    let data: T?
    let token: String?
    
}
