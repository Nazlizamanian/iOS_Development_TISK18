//
//  Day.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 10/03/25.
//
import SwiftData
import Foundation 

@Model
final class Day {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    var meals: [Meal]

    init(date: Date, meals: [Meal] = []) {
        self.date = date
        self.meals = meals
    }
}
