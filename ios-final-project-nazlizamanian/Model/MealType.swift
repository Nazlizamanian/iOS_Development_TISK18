//
//  MealType.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/03/25.
//

import Foundation

enum Meat: String, CaseIterable {
    case beef = "beef"
    case cow = "cow"
    case chicken = "chicken"
    case fish = "fish"
    case lamb = "lamb"
    case shrimp = "shrimp"
}

enum MealType: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snacks"

    var title: String { rawValue }
    var iconName: String {
        if self == .breakfast { return "cup.and.saucer"}
        else if self == .lunch || self == .dinner { return "fork.knife.circle" }
        else { return "takeoutbag.and.cup.and.straw"}
       
    }
}
