//
//  WeatherRepository.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 08.09.25.
//

import Foundation


final class RemoteWeatherRepository: WeatherRepository {
<<<<<<< HEAD:Reiseapp/Reiseapp/03_Weather/Repository/WeatherRepository.swift
    // TODO: Ersetze durch sicheren Key-Mechanismus
    private let apiKey = ""

=======
    private let apiKey = APIKeys.openWeatherMap.rawValue
    
>>>>>>> main:Reiseapp/Reiseapp/03_Weather/Repository/RemoteWeatherRepository.swift
    func fetchWeather(for city: String) async throws -> WeatherInfo {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string:
                                "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)&units=metric&lang=de"
              ) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        
        guard (200..<300).contains(http.statusCode) else {
            if let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = obj["message"] as? String {
                throw NSError(domain: "OpenWeather", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
            }
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(WeatherInfo.self, from: data)
    }
}
