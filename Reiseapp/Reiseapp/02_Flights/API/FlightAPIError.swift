//
//  Untitled.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//

import Foundation

enum FlightAPIError: Error, LocalizedError {
    case invalidRequest
    case server
    case decoding
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidRequest: return "Ungültige Anfrage."
        case .server:         return "Serverfehler."
        case .decoding:       return "Antwort konnte nicht gelesen werden."
        case .unknown:        return "Unbekannter Fehler."
        }
    }
}
