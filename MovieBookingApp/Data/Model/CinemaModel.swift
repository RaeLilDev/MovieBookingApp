//
//  CinemaModel.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/2/22.
//

import Foundation

protocol CinemaModel {
    
    func getCinemaList(completion: @escaping (MBAResult<[CinemaVO]>) -> Void)
    
    func getCinemaDayTimeSlots(date: String, movieId: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void)
    
    func getMovieSeatPlans(date: String, slotId: String, completion: @escaping (MBAResult<[SeatVO]>) -> Void)
    
}

class CinemaModelImpl: BaseModel, CinemaModel {
    
    private let cinemaRepository: CinemaRepository = CinemaRepositoryImpl.shared
    
    static let shared = CinemaModelImpl()
    
    let defaults = MBADefaults.shared
    
    private override init() { }
    
    func getCinemaList(completion: @escaping (MBAResult<[CinemaVO]>) -> Void) {
        networkAgent.getCinemaList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.cinemaRepository.saveCinemaList(data: data)
                completion(.success(data))
                
            case .failure(let message):
                completion(.failure(message))
            }
            
            self.cinemaRepository.getCinemaList { completion(.success($0)) }
        }
    }
    
    func getCinemaDayTimeSlots(date: String, movieId: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void) {
        networkAgent.getCinemaDayTimeSlots(token: defaults.getDefaultUserToken(), date: date, movieId: movieId) { result in
            switch result {
            case .success(let data):
                
                self.cinemaRepository.saveCinemaDayTimeSlots(for: date, data: data)
                
                completion(.success(data))
                
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.cinemaRepository.getCinemaDayTimeSlots(for: date) { completion(.success($0)) }
        }
    }
    
    func getMovieSeatPlans(date: String, slotId: String, completion: @escaping (MBAResult<[SeatVO]>) -> Void) {
        
        networkAgent.getMovieSeatPlan(token: defaults.getDefaultUserToken(), slotId: slotId, date: date) { result in
            switch result {
            case .success(let data):
                self.cinemaRepository.saveSeatPlan(slotId: slotId, date: date, data: data)
                
                
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.cinemaRepository.getSeatPlan(slotId: slotId, date: date) { completion(.success($0)) }
        }
    }
}
