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
class CalendarHelper  {
    
    var currentDate: Date = Date()
    let calendar = Calendar.current
    
    var currentMonthText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: currentDate)
    }
    
    func changeMonth(by value: Int){
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate){
            currentDate = newDate
        }
    }
    
    func generateDaysForMonth() -> [Int] { //Chatis modified
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let firstOfMonth = calendar.date(from: components) else {
            return []
        }
        
        let weekday = calendar.component(.weekday, from: firstOfMonth)
        // Determine number of days in the month
        guard let range = calendar.range(of: .day, in: .month, for: firstOfMonth) else { return [] }
        let numDays = range.count
        
        var days = [Int]()
        // Calculate the number of leading empty cells so that the first day aligns correctly
        let firstWeekday = calendar.firstWeekday
        var leadingEmptyDays = weekday - firstWeekday
        if leadingEmptyDays < 0 { leadingEmptyDays += 7 }
        for _ in 0..<leadingEmptyDays {
            days.append(0)
        }
        
        for day in 1...numDays {
            days.append(day)
        }
        return days
    }
    
    func getDate(for day: Int) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        components.day = day
        return calendar.date(from: components) ?? Date()
    }
}
