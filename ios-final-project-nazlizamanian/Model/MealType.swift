//
//  MealType.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/03/25.
//

import Foundation

enum MealType: String, CaseIterable, Codable, Identifiable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snacks"

    var id: String { rawValue }
    var title: String { rawValue }

    var iconName: String {
        switch self {
        case .breakfast:
            return "cup.and.saucer"
        case .lunch, .dinner:
            return "fork.knife.circle"
        case .snacks:
            return "takeoutbag.and.cup.and.straw"
        }
    }
}

