//
//  MovieRepository.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation
import RealmSwift

protocol MovieRepository {
    
    func saveList(type: MovieType, data: [MovieVO])
    
    func saveDetail(data: MovieVO)
    
    func getDetail(id: Int, completion: @escaping (MBAResult<MovieVO>) -> Void)
    
    
}

class MovieRepositoryImpl: BaseRepository, MovieRepository {
    
    static let shared: MovieRepository = MovieRepositoryImpl()
    
    private let contentTypeRepo: ContentTypeRepository = ContentTypeRepositoryImpl.shared
    
    private override init() { }
    
    func saveList(type: MovieType, data: [MovieVO]) {
        let objects = List<MovieVO>()
        
        objects.append(objectsIn: data)

        try! realmInstance.db.write {
            realmInstance.db.add(objects, update: .modified)
        }
    }
    
    func saveDetail(data: MovieVO) {
        
        try! realmInstance.db.write {
            realmInstance.db.create(MovieVO.self, value: [
               "id": data.id,
               "overview": data.overview,
               "rating": data.rating,
               "runtime": data.runtime,
               "casts": data.casts
            ], update: .modified)
        }
    }
    
    func getDetail(id: Int, completion: @escaping (MBAResult<MovieVO>) -> Void) {
        
        guard let object = realmInstance.db.object(ofType: MovieVO.self, forPrimaryKey: id) else {
                   return
        }
        completion(.success(object))
        
    }
    
}
