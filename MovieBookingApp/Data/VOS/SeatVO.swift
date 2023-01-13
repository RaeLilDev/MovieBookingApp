//
//  SeatVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/5/22.
//

import Foundation
import RealmSwift

class SeatVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var timeSlotDateAndMovieId: String
    
    @Persisted
    var seatId: Int
    
    @Persisted
    var type: String
    
    @Persisted
    var seatName: String
    
    @Persisted
    var symbol: String
    
    @Persisted
    var price: Int
    
    enum CodingKeys: String, CodingKey {
        case seatId = "id"
        case type
        case seatName = "seat_name"
        case symbol
        case price
    }
    
    func isMovieSeatAvailable() -> Bool {
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isMovieSeatTaken() -> Bool {
        return type == SEAT_TYPE_TAKEN
    }
    
    func isMovieSeatRowTitle() -> Bool {
        return type == SEAT_TYPE_TEXT
    }
    
    func isMovieSeatSelected() -> Bool {
        return type == SEAT_TYPE_SELECTED
    }
    
    func toMovieSeatVO() -> MovieSeatVO {
        return MovieSeatVO(id: seatId, type: type, seatName: seatName, symbol: symbol, price: price)
    }
    
    
}
