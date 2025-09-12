//
//  Untitled.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//

import Foundation

enum FlightAPIError: LocalizedError {
    case invalidRequest
    case serverError
    case decodingError
    case invalidResponse
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidRequest: return "Ungültige Anfrage."
        case .serverError: return "Serverfehler."
        case .decodingError: return "Antwort konnte nicht verarbeitet werden."
        case .invalidResponse: return "Ungültige Antwort vom Server."
        case .unknown: return "Unbekannter Fehler."
        }
    }
}
