//
//  CastVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation
import RealmSwift

class CastVO: Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var gender: Int
    @Persisted
    var adult: Bool
    @Persisted
    var knownForDepartment: String
    @Persisted
    var name: String
    @Persisted
    var originalName: String
    @Persisted
    var popularity: String
    @Persisted
    var profilePath: String
    @Persisted
    var castId: Int
    @Persisted
    var character: String
    @Persisted
    var creditId: String
    @Persisted
    var order: Int
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case id, gender, adult
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }
    
    
}
