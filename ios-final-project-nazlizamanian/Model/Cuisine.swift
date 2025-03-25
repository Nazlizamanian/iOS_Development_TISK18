//
//  Cuisine.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 05/03/25.
//

enum Cuisine: String, Identifiable {
    case american = "American"
    case brazilian = "Brazilian"
    case cuban = "Cuban"
    case greek = "Greek"
    case hawaiian = "Hawaiian"
    case indian = "Indian"
    case italian = "Italian"
    case japanese = "Japanese"
    case korean = "Korean"
    case lebanese = "Lebanese"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case moroccan = "Moroccan"
    case pakistani = "Pakistani"
    case russian = "Russian"
    case spanish = "Spanish"
    case thai = "Thai"
    case turkish = "Turkish"
    case vietnamese = "Vietnamese"
    
    var id: String { rawValue }
    
    var flag: String {
        switch self {
        case .american: return "🇺🇸"
        case .brazilian: return "🇧🇷"
        case .cuban: return "🇨🇺"
        case .greek: return "🇬🇷"
        case .hawaiian: return "🌺"
        case .indian: return "🇮🇳"
        case .italian: return "🇮🇹"
        case .japanese: return "🇯🇵"
        case .korean: return "🇰🇷"
        case .lebanese: return "🇱🇧"
        case .mediterranean: return "🇬🇷" 
        case .mexican: return "🇲🇽"
        case .moroccan: return "🇲🇦"
        case .pakistani: return "🇵🇰"
        case .russian: return "🇷🇺"
        case .spanish: return "🇪🇸"
        case .thai: return "🇹🇭"
        case .turkish: return "🇹🇷"
        case .vietnamese: return "🇻🇳"
        }
    }
}

