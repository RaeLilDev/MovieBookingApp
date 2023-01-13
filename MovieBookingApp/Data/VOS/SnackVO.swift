//
//  SnackVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/6/22.
//

import Foundation
import RealmSwift

class SnackVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var desc: String
    
    @Persisted
    var price: Int
    
    @Persisted
    var image: String
    
    var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case price
        case image
    }
}
