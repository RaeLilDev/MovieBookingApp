//
//  ProfileVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/25/22.
//

import Foundation
import RealmSwift

class ProfileVO: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var email: String
    
    @Persisted
    var phone: String
    
    @Persisted
    var totalExpense: Int
    
    @Persisted
    var profileImage: String
    
    @Persisted
    var cards: List<CardVO>
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
        case cards
    }
}
