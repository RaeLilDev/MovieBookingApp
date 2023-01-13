//
//  MockCinemaModel.swift
//  MovieBookingAppTests
//
//  Created by Ye linn htet on 6/21/22.
//

import Foundation
@testable import MovieBookingApp


class MockCinemaModel: CinemaModel {
    
    var isError: Bool = false
    
    func getCinemaList(completion: @escaping (MBAResult<[CinemaVO]>) -> Void) {
        
    }
    
    func getCinemaDayTimeSlots(date: String, movieId: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void) {
        
    }
    
    
    func getMovieSeatPlans(date: String, slotId: String, completion: @escaping (MBAResult<[SeatVO]>) -> Void) {
        
        if isError {
            completion(.failure("Something went wrong."))
        } else {
            let mockedDataFromJSON = try! Data(contentsOf: CinemaMockData.MovieSeatPlan.MovieSeatPlanJSONUrl)
            
            let responseData = try! JSONDecoder().decode(MBAResponse<[[SeatVO]]>.self, from: mockedDataFromJSON)
            
            let results = responseData.data!.flatMap { $0 }

            completion(.success(results))
        }
        
        
        
    }
    
    
}
