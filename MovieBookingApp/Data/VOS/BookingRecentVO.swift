//
//  BookingRecentVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/4/22.
//

import Foundation

class BookingRecentVO {
    
    static let shared = BookingRecentVO()
    
    var movieId: Int?
    var movieName: String?
    var posterPath: String?
    var duration: Int?
    
    var cinemaId: Int?
    var cinemaName: String?
    var timeSlotId: Int?
    var startTime: String?
    
    var date: String?
    var weekDay: String?
    var dayMonth: String?
    var time: String?
    
    var ticketCount: Int?
    var seatNames: String?
    var row: String?
    var price: Int?
    
    var cardId: Int?
    
    var seatNumberPerRow: Int?
    
    var snacks = [[String: Int]]()
    
    
    
    
    func toBookingVO() -> BookingVO {
        BookingVO(
            cinemaDayTimeSlotID: timeSlotId ?? 0,
            row: row ?? "",
            seatNumber: seatNames ?? "",
            bookingDate: date ?? "",
            totalPrice: Double(price ?? 0),
            movieId: movieId ?? 0,
            cardId: cardId ?? 0,
            cinemaID: cinemaId ?? 0,
            snacks: snacks)
    }
    
}
