//
//  ShoppingListViewModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import Foundation
import SwiftUI
import Observation

/*
 https://www.hackingwithswift.com/forums/swiftui/date-in-different-format/6344
 */

@Observable
class CalendarHelper {
    
    var currentDate: Date = Date()
    
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        return calendar
    }()
    
   let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY" // för o få månad o år
        return formatter
    }()
    
    var currentMonthText: String {
        dateFormatter.string(from: currentDate)
    }
    
    func changeMonth(by value: Int){
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate){
            currentDate = newDate
        }
    }
    
    func generateDaysForMonth() -> [Int] {
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return [] }
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let weekDayOfFirstDay = calendar.component(.weekday, from: firstDayOfMonth)

        let offset = (weekDayOfFirstDay - calendar.firstWeekday + 7) % 7
        let emptyDays = Array(repeating: 0, count: offset)
        let days = Array(range)

        return emptyDays + days
    }

    
    func getDate(for day: Int) -> Date {
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        if let correctedDate = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
            return correctedDate
        }
        return Date() 
    }

    
}
