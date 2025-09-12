//
//  FlightRepository.swift
//  Reiseapp
//
//  Created by Jeff Braun on 11.09.25.
//

import Foundation

// FLIGHTAPI
protocol FlightRepository {
    func searchFlights(from cityFrom: String, to cityTo: String, earliest: Date, returnDate: Date?) async throws -> [Flight]
}
