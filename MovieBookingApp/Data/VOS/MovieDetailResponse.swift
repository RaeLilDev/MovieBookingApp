//
//  MovieDetailResponse.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/30/22.
//

import Foundation
import RealmSwift

// MARK: - Welcome
struct Movie: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let overview: String?
    let rating: Double?
    let runtime: Int?
    let posterPath: String?
    let casts: [Cast]?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres, overview, rating, runtime
        case posterPath = "poster_path"
        case casts
    }
    
    
    func toMovieVO(groupType: BelongsToTypeObject) -> MovieVO {
        let object = MovieVO()
        
        object.id = id ?? 0
        object.originalTitle = originalTitle ?? ""
        object.releaseDate = releaseDate ?? ""
        object.posterPath = posterPath ?? ""
        let genresList = List<String>()
        genresList.append(objectsIn: genres ?? [String]())
        object.genres = genresList
        object.belongsToType.append(groupType)
        
        return object
    }
    
    func toMovieVO() -> MovieVO {
        let object = MovieVO()
        
        object.id = id ?? 0
        object.originalTitle = originalTitle ?? ""
        object.releaseDate = releaseDate ?? ""
        object.posterPath = posterPath ?? ""
        let genresList = List<String>()
        genresList.append(objectsIn: genres ?? [String]())
        object.genres = genresList
        object.overview = overview ?? ""
        object.rating = rating ?? 0.0
        object.runtime = runtime ?? 0
        
        self.casts?.forEach {
            object.casts.append($0.toCastObject())
        }
        
        return object
    }
}


// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
    
    func toCastObject() -> CastVO {
        let object = CastVO()
        
        object.adult = adult ?? false
        object.gender = gender ?? 0
        object.id = id ?? 0
        object.knownForDepartment = knownForDepartment ?? ""
        object.name = name ?? ""
        object.originalName = originalName ?? ""
        object.popularity = "\(popularity ?? 0.0)"
        object.profilePath = profilePath ?? ""
        object.castId = castID ?? 0
        object.character = character ?? ""
        object.creditId = creditID ?? ""
        object.order = order ?? 0
        return object
    }
}
