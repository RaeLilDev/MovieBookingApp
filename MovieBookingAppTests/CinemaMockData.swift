//
//  CinemaMockData.swift
//  MovieBookingAppTests
//
//  Created by Ye linn htet on 6/21/22.
//

import Foundation

public final class CinemaMockData {
    
    class MovieSeatPlan {
        public static let MovieSeatPlanJSONUrl: URL = Bundle(for: CinemaMockData.self).url(forResource: "cinema_seating_plan", withExtension: "json")!
    }
    
}
