//
//  ProfileRepository.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/28/22.
//

import Foundation

protocol ProfileRepository {
    
    func saveProfileInfo(profileInfo: ProfileVO)
    func getProfileInfo(id: Int, completion: @escaping (MBAResult<ProfileVO>) -> Void)
}

class ProfileRepositoryImpl: BaseRepository, ProfileRepository {
    
    override private init() { }
    
    static let shared = ProfileRepositoryImpl()
    
    
    func saveProfileInfo(profileInfo: ProfileVO) {
        do {
            try realmInstance.db.write({
                realmInstance.db.add(profileInfo, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func getProfileInfo(id: Int, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        let profileObject = realmInstance.db.object(ofType: ProfileVO.self, forPrimaryKey: id)!
        
        completion(.success(profileObject))
    }
}
    
