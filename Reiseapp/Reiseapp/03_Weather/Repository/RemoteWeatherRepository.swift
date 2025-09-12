//
//  WeatherRepository.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 08.09.25.
//

import Foundation

final class RemoteWeatherRepository: WeatherRepository {
    private let apiKey = APIKeys.openWeatherMap.rawValue

    func fetchWeather(for city: String) async throws -> WeatherInfo {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string:
                                "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)&units=metric&lang=de"
              ) else {
            throw WeatherError.cityNotFound(city) // passt zum Mock
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse else {
            throw WeatherError.cityNotFound(city) // kein HTTP Response → City nicht gefunden
        }
        
        guard (200..<300).contains(http.statusCode) else {
            if let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = obj["message"] as? String,
               message.lowercased().contains("city not found") {
                throw WeatherError.cityNotFound(city)
            }
            throw WeatherError.cityNotFound(city)
        }
        
        do {
            return try JSONDecoder().decode(WeatherInfo.self, from: data)
        } catch {
            throw WeatherError.cityNotFound(city)
        }
    }
}
