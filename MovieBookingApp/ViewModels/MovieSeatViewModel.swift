//
//  MovieSeatViewModel.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 6/20/22.
//

import Foundation
import Combine
import RxCocoa
import RxSwift

enum MovieSeatViewState {
    case error(message: String)
    case successFetchingSeats
    case updateSelectedUI
    case goToSnackView(ticketPrice: Int)
}



class MovieSeatViewModel: MovieSeatViewModelType {
    
    var viewState = BehaviorRelay<MovieSeatViewState?>(value: nil)
    
    var bookingRecent = BookingRecentVO.shared
    var cinemaModel:CinemaModel = CinemaModelImpl.shared
    
    var seatList = [MovieSeatVO]()
    var selectedSeatList = [MovieSeatVO]()
    
    var ticketCount = 0
    var seatNames = ""
    var row = ""
    var ticketPrice = 0
    
    init(cinemaModel: CinemaModel) {
        self.cinemaModel = cinemaModel
        fetchSeatPlanList()
    }
    
//
//    init() {
//        fetchSeatPlanList()
//    }
    
    
    func fetchSeatPlanList() {
        
        cinemaModel.getMovieSeatPlans(date: bookingRecent.date ?? "", slotId: "\(bookingRecent.timeSlotId ?? 1)") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
                self.seatList = data.map { $0.toMovieSeatVO() }
                self.viewState.accept(.successFetchingSeats)
                
            case .failure(let message):
                self.viewState.accept(.error(message: message))
            }
        }
        
    }
    
    
    func getTotalSelectedSeatPrice() -> Int {
        var total = 0
        selectedSeatList.forEach {
            total += $0.price!
        }
        return total
    }
    
    
    func didSelectMovieSeat(index: Int) {
        if seatList[index].isMovieSeatAvailable() {
            
            didSelectAvailableSeat(index: index)
            
        } else if seatList[index].isMovieSeatSelected() {
            
            didSelectSelectedSeat(index: index)
            
        }
    }
    
    func didSelectAvailableSeat(index: Int) {
        seatList[index].type = SEAT_TYPE_SELECTED
        selectedSeatList.append(seatList[index])
        
        ticketCount = selectedSeatList.count
        seatNames = selectedSeatList.map { $0.seatName!}.joined(separator: ",")
        row = Set(selectedSeatList.map { $0.symbol!}).joined(separator: ",")
        ticketPrice = getTotalSelectedSeatPrice()
        viewState.accept(.updateSelectedUI)
    }
    
    
    func didSelectSelectedSeat(index: Int) {
        
        seatList[index].type = SEAT_TYPE_AVAILABLE
        if let selectedIndex = selectedSeatList.firstIndex(where: { $0 === seatList[index] }) {
            selectedSeatList.remove(at: selectedIndex)
        }
        
        ticketCount = selectedSeatList.count
        seatNames = selectedSeatList.map { $0.seatName!}.joined(separator: ",")
        row = Set(selectedSeatList.map { $0.symbol!}).joined(separator: ",")
        ticketPrice = getTotalSelectedSeatPrice()
        viewState.accept(.updateSelectedUI)
        
    }
    
    
    func navigateToSnackViewController() {
        if isValidToNavigate() {
            bookingRecent.ticketCount = ticketCount
            bookingRecent.row = row
            bookingRecent.seatNames = seatNames
            viewState.accept(.goToSnackView(ticketPrice: ticketPrice))
        } else {
            viewState.accept(.error(message: "Please select seats first."))
        }
    }
    
    
    
    func isValidToNavigate() -> Bool {
        return seatNames != "" && row != "" && ticketCount != 0
    }
    
    
    func getMovieName() -> String {
        return bookingRecent.movieName ?? ""
    }
    
    func getCinemaName() -> String {
        return bookingRecent.cinemaName ?? ""
    }
    
    func getWeekDay() -> String {
        return bookingRecent.weekDay ?? ""
    }
    
    func getDayMonth() -> String {
        return bookingRecent.dayMonth ?? ""
    }
    
    func getStartTime() -> String {
        return bookingRecent.startTime ?? ""
    }
    
    
    func getSeatNumbersPerRow() -> Int {
        return bookingRecent.seatNumberPerRow ?? 1
    }
    
    func getSeatCount() -> Int {
        return seatList.count
    }
    
}
