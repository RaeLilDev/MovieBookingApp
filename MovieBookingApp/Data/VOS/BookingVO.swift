//
//  BookingVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/10/22.
//

import Foundation

struct BookingVO: Codable {
    
    var cinemaDayTimeSlotID = 0
    var row = ""
    var seatNumber = ""
    var bookingDate = ""
    var totalPrice = 0.0
    var movieId = 0
    var cardId = 0
    var cinemaID = 0
    var snacks = [[String: Int]]()
        
    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeSlotID = "cinema_day_timeslot_id"
        case row
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case totalPrice = "total_price"
        case movieId = "movie_id"
        case cardId = "card_id"
        case cinemaID = "cinema_id"
        case snacks = "snacks"
    }
    
}
