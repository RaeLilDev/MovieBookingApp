//
//  CinemaDayTimeSlotResponse.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/3/22.
//

import Foundation
import RealmSwift

struct CinemaDayTimeSlotResponse: Codable {
    
    let cinemaID: Int?
    let cinema: String?
    let timeslots: [Timeslot]?

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }
    
    func toCinemaDayTimeSlotVO() -> CinemaDayTimeSlotVO {
        let object = CinemaDayTimeSlotVO()
        object.cinemaId = cinemaID ?? 0
        object.cinemaName = cinema ?? ""
        timeslots!.forEach {
            object.timeslots.append($0.toTimeSlotVO())
        }
        return object
    }
}

// MARK: - Timeslot
struct Timeslot: Codable {
    let cinemaDayTimeslotID: Int?
    let startTime: String?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
    
    func toTimeSlotVO() -> TimeSlotVO {
        let object = TimeSlotVO()
        object.id = cinemaDayTimeslotID ?? 0
        object.startTime = startTime ?? ""
        return object
    }
}
