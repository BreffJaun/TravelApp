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

    private enum CodingKeys: String, CodingKey { case city = "name", main, weather, wind }
    private enum MainKeys: String, CodingKey { case temp, humidity }
    private enum WeatherArrayKeys: String, CodingKey { case id, main, description }
    private enum WindKeys: String, CodingKey { case speed }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        city = try c.decode(String.self, forKey: .city)

        let main = try c.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try main.decode(Double.self, forKey: .temp)
        humidity = try main.decode(Int.self, forKey: .humidity)

        var wArray = try c.nestedUnkeyedContainer(forKey: .weather)
        let w0 = try wArray.nestedContainer(keyedBy: WeatherArrayKeys.self)
        let code = try w0.decode(Int.self, forKey: .id)
        let mainText = (try? w0.decode(String.self, forKey: .main)) ?? ""
        let descText = (try? w0.decode(String.self, forKey: .description)) ?? ""

        condition = WeatherCondition.from(id: code, main: mainText, description: descText)

        let wind = try c.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try wind.decode(Double.self, forKey: .speed)
    }

    init(city: String, temperature: Double, humidity: Int, windSpeed: Double, condition: WeatherCondition) {
        self.city = city; self.temperature = temperature; self.humidity = humidity; self.windSpeed = windSpeed; self.condition = condition
    }
}
