//
//  LocalFlightRepository.swift
//  Reiseapp
//
//  Created by Jeff Braun on 11.09.25.
//

import Foundation

final class LocalFlightRepository: FlightRepository {
    func searchFlights(from cityFrom: String, to cityTo: String, earliest: Date, returnDate: Date?) async throws -> [Flight] {
        print("🟢 LocalFlightRepository.searchFlights() called: \(cityFrom) → \(cityTo), ab \(earliest), Rückflug: \(String(describing: returnDate))")

        let calendar = Calendar.current
        let prices = [79.0, 89.0, 99.0, 120.0, 140.0, 150.0, 175.0, 200.0, 220.0, 250.0]
        let dates = (0..<prices.count).compactMap { calendar.date(byAdding: .day, value: $0, to: earliest) }

        let flights = zip(dates, prices).map { date, price in
            Flight(
                departure: cityFrom,
                destination: cityTo,
                date: date,
                priceEUR: price
            )
        }

        print("🟢 LocalFlightRepository returning \(flights.count) mock flights")
        return flights
    }
}
