//
//  MovieVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation
import RealmSwift

class MovieVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var originalTitle: String
    
    @Persisted
    var releaseDate: String
    
    @Persisted
    var overview: String
    
    @Persisted
    var rating: Double
    
    @Persisted
    var runtime: Int
    
    @Persisted
    var posterPath: String
    
    @Persisted
    var genres: List<String>
    
    @Persisted
    var casts: List<CastVO>
    
    @Persisted
    var belongsToType: List<BelongsToTypeObject>
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case overview, rating, runtime
        case posterPath = "poster_path"
        case genres, casts
    }
}
