//
//  MovieVO.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 13/02/2022.
//

import Foundation

class MovieSeatVO {
    
    var id: Int?
    var type: String?
    var seatName: String?
    var symbol: String?
    var price: Int?
    
    init(id: Int? = nil, type: String? = nil, seatName: String? = nil, symbol: String? = nil, price: Int? = nil) {
        self.id = id
        self.type = type
        self.seatName = seatName
        self.symbol = symbol
        self.price = price
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
}
