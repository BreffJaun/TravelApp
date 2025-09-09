//
//  WeatherCondition.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 09.09.25.
//

import Foundation

enum WeatherCondition: String, Equatable, Decodable {
    case clear, partlyCloudy, cloudy, rain, storm, snow, fog, unknown
    
    var sfSymbol: String {
        switch self {
        case .clear:         return "sun.max.fill"
        case .partlyCloudy:  return "cloud.sun.fill"
        case .cloudy:        return "cloud.fill"
        case .rain:          return "cloud.rain.fill"
        case .storm:         return "cloud.bolt.rain.fill"
        case .snow:          return "snow"
        case .fog:           return "smoke.fill"
        case .unknown:       return "questionmark.circle.fill"
        }
    }
    static func from(text: String) -> WeatherCondition {
            let t = text.lowercased()
            if t.contains("thunder") || t.contains("storm") || t.contains("gewit") { return .storm }
            if t.contains("rain") || t.contains("regen") { return .rain }
            if t.contains("snow") || t.contains("schnee") { return .snow }
            if t.contains("fog") || t.contains("mist") || t.contains("neb") { return .fog }
            if t.contains("overcast") { return .cloudy }
            if t.contains("cloud") || t.contains("wolk") { return .partlyCloudy }
            if t.contains("clear") || t.contains("sun") { return .clear }
            return .unknown
        }
    }

