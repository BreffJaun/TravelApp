//
//  protocoll.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 10.09.25.
//

import Foundation

protocol WeatherRepository {
    func fetchWeather(for city: String) async throws -> WeatherInfo
}
