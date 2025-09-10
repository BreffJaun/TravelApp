//
//  MockWeatherRepository.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 10.09.25.
//

import Foundation

final class MockWeatherRepository: WeatherRepository {
    private let samples: [String: WeatherInfo] = [
        "berlin":      .init(city: "Berlin",      temperature: 22.5, humidity: 55, windSpeed: 3.2, condition: .partlyCloudy),
        "hamburg":     .init(city: "Hamburg",     temperature: 19.8, humidity: 68, windSpeed: 5.1, condition: .cloudy),
        "münchen":     .init(city: "München",     temperature: 24.1, humidity: 50, windSpeed: 2.6, condition: .clear),
        "munchen":     .init(city: "München",     temperature: 24.1, humidity: 50, windSpeed: 2.6, condition: .clear),
        "köln":        .init(city: "Köln",        temperature: 21.3, humidity: 60, windSpeed: 3.9, condition: .partlyCloudy),
        "koln":        .init(city: "Köln",        temperature: 21.3, humidity: 60, windSpeed: 3.9, condition: .partlyCloudy),
        "frankfurt":   .init(city: "Frankfurt",   temperature: 26.7, humidity: 47, windSpeed: 2.2, condition: .clear),
        "stuttgart":   .init(city: "Stuttgart",   temperature: 23.0, humidity: 58, windSpeed: 3.0, condition: .cloudy),
        "düsseldorf":  .init(city: "Düsseldorf",  temperature: 20.4, humidity: 70, windSpeed: 4.8, condition: .rain),
        "dusseldorf":  .init(city: "Düsseldorf",  temperature: 20.4, humidity: 70, windSpeed: 4.8, condition: .rain),
        "leipzig":     .init(city: "Leipzig",     temperature: 18.9, humidity: 72, windSpeed: 5.5, condition: .fog),
        "hannover":    .init(city: "Hannover",    temperature: 17.2, humidity: 76, windSpeed: 6.1, condition: .rain),
        "nürnberg":    .init(city: "Nürnberg",    temperature: 16.5, humidity: 80, windSpeed: 3.3, condition: .storm),
        "nurnberg":    .init(city: "Nürnberg",    temperature: 16.5, humidity: 80, windSpeed: 3.3, condition: .storm),
        "bremen":      .init(city: "Bremen",      temperature: 20.1, humidity: 65, windSpeed: 4.1, condition: .partlyCloudy),
        "dresden":     .init(city: "Dresden",     temperature: 22.0, humidity: 60, windSpeed: 3.6, condition: .clear),
        "rostock":     .init(city: "Rostock",     temperature: 18.3, humidity: 75, windSpeed: 5.8, condition: .rain),
        "paris":       .init(city: "Paris",       temperature: 25.0, humidity: 52, windSpeed: 3.0, condition: .clear),
        "london":      .init(city: "London",      temperature: 19.5, humidity: 70, windSpeed: 4.2, condition: .fog),
        "madrid":      .init(city: "Madrid",      temperature: 31.2, humidity: 35, windSpeed: 2.1, condition: .clear),
        "rome":        .init(city: "Rom",         temperature: 29.8, humidity: 40, windSpeed: 3.4, condition: .clear),
        "vienna":      .init(city: "Wien",        temperature: 27.1, humidity: 48, windSpeed: 2.9, condition: .partlyCloudy),
        "amsterdam":   .init(city: "Amsterdam",   temperature: 20.7, humidity: 68, windSpeed: 4.7, condition: .rain),
        "oslo":        .init(city: "Oslo",        temperature: 14.3, humidity: 80, windSpeed: 3.8, condition: .cloudy),
        "stockholm":   .init(city: "Stockholm",   temperature: 16.4, humidity: 75, windSpeed: 4.5, condition: .partlyCloudy),
        "helsinki":    .init(city: "Helsinki",    temperature: 13.9, humidity: 82, windSpeed: 5.0, condition: .fog),
        "new york":    .init(city: "New York",    temperature: 27.0, humidity: 65, windSpeed: 3.5, condition: .storm),
        "los angeles": .init(city: "Los Angeles", temperature: 30.2, humidity: 40, windSpeed: 2.0, condition: .clear),
        "tokyo":       .init(city: "Tokio",       temperature: 28.5, humidity: 70, windSpeed: 4.5, condition: .rain),
        "beijing":     .init(city: "Peking",      temperature: 32.0, humidity: 55, windSpeed: 3.3, condition: .clear),
        "moscow":      .init(city: "Moskau",      temperature: 18.7, humidity: 75, windSpeed: 3.6, condition: .cloudy),
        "rio":         .init(city: "Rio de Janeiro", temperature: 26.4, humidity: 80, windSpeed: 5.5, condition: .rain),
        "cape town":   .init(city: "Kapstadt",    temperature: 22.0, humidity: 60, windSpeed: 6.0, condition: .fog),
        "sydney":      .init(city: "Sydney",      temperature: 24.5, humidity: 65, windSpeed: 5.0, condition: .partlyCloudy),
        "cairo":       .init(city: "Kairo",       temperature: 35.0, humidity: 25, windSpeed: 3.0, condition: .clear),
        "delhi":       .init(city: "Delhi",       temperature: 33.0, humidity: 60, windSpeed: 2.8, condition: .storm)
    ]
    
    func fetchWeather(for city: String) async throws -> WeatherInfo {
        let key = city
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        if let hit = samples[key] {
            return hit
        }
        
       //einfache „fuzzy“ Hilfe – wir finden einen Teiltreffer
        if let (_, v) = samples.first(where: { $0.key.contains(key) || key.contains($0.key) }) {
            return v
        }
        throw WeatherError.cityNotFound(city)
    }
}
