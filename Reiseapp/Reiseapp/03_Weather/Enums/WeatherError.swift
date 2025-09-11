//
//  WeatherError.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 10.09.25.
//

import Foundation

enum WeatherError: LocalizedError {
    case cityNotFound(String)

    var errorDescription: String? {
        switch self {
        case .cityNotFound(let city):
            return "Ort „\(city)“ wurde nicht gefunden."
        }
    }
}
