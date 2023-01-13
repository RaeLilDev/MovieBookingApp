//
//  DayTimeSlotVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/3/22.
//

import Foundation
import RealmSwift

class CinemaDayTimeSlotVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var cinemaId: Int
    
    @Persisted
    var cinemaName: String
    
    @Persisted
    var timeslots: List<TimeSlotVO>
    
    @Persisted
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case cinemaId = "cinema_id"
        case cinemaName = "cinema"
        case timeslots
    }
    
}
