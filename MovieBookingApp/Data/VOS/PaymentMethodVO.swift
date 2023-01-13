//
//  PaymentMethodVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/6/22.
//

import Foundation
import RealmSwift

class PaymentMethodVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var desc: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
    }
    
}
