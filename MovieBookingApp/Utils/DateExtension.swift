//
//  DateExtension.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 5/2/22.
//

import Foundation


extension Date {
    func getTenDaysFromNow() -> [DateVO] {
        var dateVOs = [DateVO]()
        
        let currentDate = Date()
        var dateComponents = DateComponents()
        
        let dayStringFormatter = DateFormatter()
        dayStringFormatter.timeZone = .current
        dayStringFormatter.locale = .current
        dayStringFormatter.dateFormat = "EEE"
        
        let dayNumberFormatter = DateFormatter()
        dayNumberFormatter.timeZone = .current
        dayNumberFormatter.locale = .current
        dayNumberFormatter.dateFormat = "dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dayMonthFormatter = DateFormatter()
        dayMonthFormatter.timeZone = .current
        dayMonthFormatter.locale = .current
        dayMonthFormatter.dateFormat = "dd MMM"
        
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.timeZone = .current
        weekDayFormatter.locale = .current
        weekDayFormatter.dateFormat = "EEEE"
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = .current
        timeFormatter.locale = .current
        timeFormatter.dateFormat = "hh:mm a"
        
        for day in 0..<10 {
            dateComponents.day = day
            let newDate = Calendar.current.date(byAdding: dateComponents, to: currentDate)
            let dayString = dayStringFormatter.string(from: newDate ?? Date())
            let dayNumber = dayNumberFormatter.string(from: newDate ?? Date())
            let date = dateFormatter.string(from: newDate ?? Date())
            let dayMonth = dayMonthFormatter.string(from: newDate ?? Date())
            let weekDay = weekDayFormatter.string(from: newDate ?? Date())
            let time = timeFormatter.string(from: newDate ?? Date())
            
            dateVOs.append(DateVO(dayString: dayString, dayNumber: dayNumber, date: date, dayMonth: dayMonth, weekDay: weekDay, time: time, isSelected: false))
        }
        
        return dateVOs
    }
}
