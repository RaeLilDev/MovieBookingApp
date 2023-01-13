//
//  ContentTypeRepository.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation

protocol ContentTypeRepository {
    
    func getNowShowingOrUpcoming(type: MovieType, completion: @escaping ([MovieVO]) -> Void)
    
    func getBelongsToTypeObject(type: MovieType) -> BelongsToTypeObject
    
    func save(name: String) -> BelongsToTypeObject
    
}

class ContentTypeRepositoryImpl: BaseRepository, ContentTypeRepository {
    
    static let shared: ContentTypeRepository = ContentTypeRepositoryImpl()
    
    private var contentTypeMap = [String: BelongsToTypeObject]()
    
    private override init() {
        super.init()
        
        initializeData()
    }
    
    private func initializeData() {
        
        let dataSource = realmInstance.db.objects(BelongsToTypeObject.self)
                
        if dataSource.isEmpty {
            MovieType.allCases.forEach {
                let _ = save(name: $0.rawValue)
            }
        } else {
            dataSource.forEach {
                contentTypeMap[$0.name] = $0
            }
        }
        
    }
    
    func getNowShowingOrUpcoming(type: MovieType, completion: @escaping ([MovieVO]) -> Void) {
        if let object = contentTypeMap[type.rawValue] {
            let items:[MovieVO] = object.movies.map { $0 }
            
            completion(items)
        } else {
            completion([MovieVO]())
        }
    }
    
    func getBelongsToTypeObject(type: MovieType) -> BelongsToTypeObject {
        if let object = contentTypeMap[type.rawValue] {
            return object
        }
        return save(name: type.rawValue)
    }
    
    func save(name: String) -> BelongsToTypeObject {
        
        let object = BelongsToTypeObject()
        object.name = name
        contentTypeMap[name] = object
        
        try! realmInstance.db.write {
            realmInstance.db.add(object, update: .modified)
        }
        
        return object
    }
    
    
    
    
    
}
