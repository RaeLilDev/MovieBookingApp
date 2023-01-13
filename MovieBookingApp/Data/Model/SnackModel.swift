//
//  SnackModel.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/6/22.
//

import Foundation

protocol SnackModel {
    func getSnacks(completion: @escaping (MBAResult<[SnackVO]>) -> Void)
}

class SnackModelImpl: BaseModel, SnackModel {
    
    static let shared = SnackModelImpl()
    
    let defaults = MBADefaults.shared
    
    private override init() { }
    
    let snackRepository: SnackRepository = SnackRepositoryImpl.shared
    
    func getSnacks(completion: @escaping (MBAResult<[SnackVO]>) -> Void) {
        
        networkAgent.getSnackList(token: defaults.getDefaultUserToken()) { result in
            switch result {
            case .success(let data):
                self.snackRepository.saveSnacks(data: data)
                
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.snackRepository.getSnacks { completion(.success($0)) }
        }
    }
}
