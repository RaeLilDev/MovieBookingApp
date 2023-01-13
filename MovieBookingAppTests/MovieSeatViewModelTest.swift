//
//  MovieSeatViewModelTest.swift
//  MovieBookingAppTests
//
//  Created by Ye linn htet on 6/21/22.
//
import XCTest
@testable import MovieBookingApp
import RxSwift
import RxCocoa

class MovieSeatViewModelTest: XCTestCase {
    var viewModel: MovieSeatViewModel!
    var cinemaModel: MockCinemaModel!
    
    var disposeBag: DisposeBag!

    
    
    override func setUpWithError() throws {
        
        cinemaModel = MockCinemaModel()
        
        viewModel = MovieSeatViewModel(cinemaModel: cinemaModel)
        
        disposeBag = DisposeBag()
    
        
    }
    
    override func tearDownWithError() throws {
        cinemaModel = nil
        viewModel = nil
    }
    
    func test_fetchAllSeatPlans_validInput_shouldReturnAllSeats() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchSeatPlanList()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .successFetchingSeats = state {
                    XCTAssertEqual(self.viewModel.getSeatCount(), 210)
                    responseExpectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    
    func test_fetchAllSeatPlans_withInvalid_showReturnErrorState() throws {
        
        cinemaModel.isError = true
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchSeatPlanList()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .error(_) = state {
                    responseExpectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
        
    }
    
    
    func test_didSelectMovieSeat_withIndex_shouldIncreaseSelectedSeatJ() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchSeatPlanList()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .successFetchingSeats = state {
                    self.viewModel.didSelectMovieSeat(index: 2)
                    self.viewModel.didSelectMovieSeat(index: 3)
                    self.viewModel.didSelectMovieSeat(index: 2)
                    XCTAssertEqual(self.viewModel.selectedSeatList.count, 1)
                    responseExpectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    func test_selectAvailableSeat_withIndex_shouldIncreaseSelectedSeat() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchSeatPlanList()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .successFetchingSeats = state {
                    self.viewModel.didSelectAvailableSeat(index: 2)
                    self.viewModel.didSelectAvailableSeat(index: 3)
                    XCTAssertEqual(self.viewModel.selectedSeatList.count, 2)
                    responseExpectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
        
    }
    
    
    func test_selectSelectedSeat_withIndex_shouldDecreaseSelectedSeat() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchSeatPlanList()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .successFetchingSeats = state {
                    
                    self.viewModel.didSelectAvailableSeat(index: 2)
                    self.viewModel.didSelectAvailableSeat(index: 3)
                    XCTAssertEqual(self.viewModel.selectedSeatList.count, 2)
                    
                    self.viewModel.didSelectSelectedSeat(index: 2)
                    XCTAssertEqual(self.viewModel.selectedSeatList.count, 1)
                    
                    responseExpectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
        
    }
    
    
    func test_totalSelectedSeatPrice_withSelectedSeat_shouldReturnTotalPrice() throws {
        
        viewModel.selectedSeatList.append(MovieSeatVO(id: 1, type: "taken", seatName: "A-1", symbol: "A", price: 2))
        viewModel.selectedSeatList.append(MovieSeatVO(id: 2, type: "taken", seatName: "A-2", symbol: "A", price: 2))
        
        XCTAssertEqual(viewModel.getTotalSelectedSeatPrice(), 4)
    }
    
    func test_navigateToSnackView_withVaildData_shouldGoToSnackView() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.seatNames = "A-1, A-2"
        viewModel.row = "A"
        viewModel.ticketCount = 2
        
        viewModel.navigateToSnackViewController()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .goToSnackView(_) = state {
                    responseExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
        
    }
    
    
    func test_navigateToSnackView_withInvalidData_shouldReturnErrorState() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.seatNames = ""
        viewModel.row = ""
        viewModel.ticketCount = 0
        
        viewModel.navigateToSnackViewController()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .error(_) = state {
                    responseExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    
    func test_bookingRecentGetMethods_withValidData_shouldSuccess() throws {
        BookingRecentVO.shared.movieName = "The Lost City"
        BookingRecentVO.shared.cinemaName = "Cinema 1"
        BookingRecentVO.shared.weekDay = "Thursday"
        BookingRecentVO.shared.dayMonth = "23 Jun"
        BookingRecentVO.shared.startTime = "12:00 PM"
        BookingRecentVO.shared.seatNumberPerRow = 12
        
        XCTAssertEqual(viewModel.getMovieName(), "The Lost City")
        XCTAssertEqual(viewModel.getCinemaName(), "Cinema 1")
        XCTAssertEqual(viewModel.getWeekDay(), "Thursday")
        XCTAssertEqual(viewModel.getDayMonth(), "23 Jun")
        XCTAssertEqual(viewModel.getStartTime(), "12:00 PM")
        XCTAssertEqual(viewModel.getSeatNumbersPerRow(), 12)
        
    }
    
    
}
