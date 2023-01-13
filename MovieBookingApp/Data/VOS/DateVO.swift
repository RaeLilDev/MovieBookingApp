//
//  DateVO.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/2/22.
//

import Foundation

class DateVO {
    
    var dayString: String
    var dayNumber: String
    var date: String
    var dayMonth: String
    var weekDay: String
    var time: String
    var isSelected: Bool = false
    
    init(dayString: String, dayNumber: String, date: String, dayMonth: String, weekDay: String, time: String, isSelected: Bool) {
        self.dayString = dayString
        self.dayNumber = dayNumber
        self.date = date
        self.dayMonth = dayMonth
        self.weekDay = weekDay
        self.time = time
        self.isSelected = isSelected
    }
}
