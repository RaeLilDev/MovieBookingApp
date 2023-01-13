//
//  SnackRepository.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/6/22.
//

import Foundation

protocol SnackRepository {
    func saveSnacks(data: [SnackVO])
    
    func getSnacks(completion: @escaping ([SnackVO]) -> Void)
}

class SnackRepositoryImpl: BaseRepository, SnackRepository {
    
    static let shared = SnackRepositoryImpl()
    
    private override init() { }
    
    func saveSnacks(data: [SnackVO]) {
        do {
            try realmInstance.db.write({
                realmInstance.db.add(data, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
        
    func getSnacks(completion: @escaping ([SnackVO]) -> Void) {
        
        completion(Array(realmInstance.db.objects(SnackVO.self)))
        
    }
}
