//
//  WeatherCondition.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 09.09.25.
//

import Foundation

enum WeatherCondition: String, Equatable {
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

    // Primär: ID-Mapping; Fallback: Text (diakritik-unempfindlich)
    static func from(id: Int, main: String, description: String) -> WeatherCondition {
        switch id {
        case 200...232: return .storm
        case 300...321: return .rain
        case 500...531: return .rain
        case 600...622: return .snow
        case 701...781: return .fog
        case 800:       return .clear
        case 801:       return .partlyCloudy
        case 802:       return .partlyCloudy
        case 803...804: return .cloudy
        default:
            return from(text: description.isEmpty ? main : description)
        }
    }

    static func from(text: String) -> WeatherCondition {
        // Umlaute neutralisieren, damit "bewölkt" -> "bewolkt"
        let t = text
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .lowercased()

        if t.contains("thunder") || t.contains("storm") || t.contains("gewitter") { return .storm }
        if t.contains("rain") || t.contains("regen") || t.contains("schauer")     { return .rain }
        if t.contains("snow") || t.contains("schnee")                              { return .snow }
        if t.contains("fog")  || t.contains("mist") || t.contains("nebel")         { return .fog }
        if t.contains("overcast") || t.contains("bedeckt")                         { return .cloudy }
        if t.contains("cloud") || t.contains("wolk") || t.contains("bewolkt")      { return .partlyCloudy }
        if t.contains("clear") || t.contains("sonnig") || t.contains("heiter")     { return .clear }
        return .unknown
    }
}

