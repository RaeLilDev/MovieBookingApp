//
//  CardVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/26/22.
//

import Foundation
import RealmSwift

class CardVO: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var cardHolder: String
    
    @Persisted
    var cardNumber: String
    
    @Persisted
    var expirationDate: String
    
    @Persisted
    var cardType: String
    
    var cvc = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case expirationDate = "expiration_date"
        case cardType = "card_type"
    }
    
    func toParameters() -> [String: Any] {
        return [
            "card_holder": cardHolder,
            "card_number": cardNumber,
            "expiration_date": expirationDate,
            "cvc": cvc
        ]
    }
}
