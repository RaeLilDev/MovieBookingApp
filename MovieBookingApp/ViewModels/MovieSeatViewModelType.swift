//
//  MovieSeatViewModelType.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 6/20/22.
//

import Foundation
import Combine

protocol MovieSeatViewModelType {
    
    var seatList: [MovieSeatVO] { get set }
    var selectedSeatList: [MovieSeatVO] { get set }
    
//    var viewState : PassthroughSubject<MovieSeatViewState, Never> { get }
 
    func fetchSeatPlanList()
    
    func getTotalSelectedSeatPrice() -> Int
    
    func didSelectMovieSeat(index: Int)
    
    func didSelectAvailableSeat(index: Int)
    
    func didSelectSelectedSeat(index: Int)
    
    func navigateToSnackViewController()
    
}
