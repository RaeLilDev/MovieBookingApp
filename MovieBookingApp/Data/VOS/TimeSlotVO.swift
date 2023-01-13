//
//  TimeSlotVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/3/22.
//

import Foundation
import RealmSwift

class TimeSlotVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var startTime: String
    
    enum CodingKeys: String, CodingKey {
        case id = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
}
