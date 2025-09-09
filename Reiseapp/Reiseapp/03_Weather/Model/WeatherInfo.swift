//
//  WeatherInfo.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 08.09.25.
//

import Foundation

struct WeatherInfo: Identifiable, Decodable {
    let id = UUID()
    let city: String
    let temperature: Double
    let humidity: Int
    let windSpeed: Double
    let condition: WeatherCondition

    // OpenWeather JSON Mapping
    private enum CodingKeys: String, CodingKey {
        case city = "name"
        case main, weather, wind
    }
    private enum MainKeys: String, CodingKey { case temp, humidity }
    private enum WeatherArrayKeys: String, CodingKey { case description }
    private enum WindKeys: String, CodingKey { case speed }

    init(city: String, temperature: Double, humidity: Int, windSpeed: Double, condition: WeatherCondition) {
        self.city = city
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.condition = condition
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(String.self, forKey: .city)

        let main = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try main.decode(Double.self, forKey: .temp)
        humidity = try main.decode(Int.self, forKey: .humidity)

        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)
        let firstWeather = try weatherArray.nestedContainer(keyedBy: WeatherArrayKeys.self)
        let desc = try firstWeather.decode(String.self, forKey: .description)
        condition = WeatherCondition.from(text: desc)

        let wind = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try wind.decode(Double.self, forKey: .speed)
    }
}
