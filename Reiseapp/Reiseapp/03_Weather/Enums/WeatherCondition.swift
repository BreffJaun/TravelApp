//
//  WeatherCondition.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 09.09.25.
//
import SwiftUICore
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
  
    static func from(text: String) -> WeatherCondition {
        
        let t = text.lowercased()
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                  .lowercased()
        
        if t.contains("thunder") || t.contains("storm") || t.contains("gewit") { return .storm }
        if t.contains("rain") || t.contains("regen") { return .rain }
        if t.contains("snow") || t.contains("schnee") { return .snow }
        if t.contains("fog") || t.contains("mist") || t.contains("neb") { return .fog }
        if t.contains("overcast") { return .cloudy }
        if t.contains("cloud") || t.contains("wolk") { return .partlyCloudy }
        if t.contains("clear") || t.contains("sun") { return .clear }
        return .unknown
    }
    
    var iconColor: Color {
        switch self {
        case .clear:         return .yellow
        case .partlyCloudy:  return .orange
        case .cloudy:        return .gray
        case .rain:          return .blue
        case .storm:         return .purple
        case .snow:          return .white
        case .fog:           return .gray
        case .unknown:       return .secondary
        }
    }
    
    func tempColor(for temperature: Double) -> Color {
        switch temperature {
        case ..<0: return .blue
        case 0..<10: return .cyan
        case 10..<20: return .green
        case 20..<30: return .orange
        default: return .red

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
}


