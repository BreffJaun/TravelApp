//
//  FlightRepository.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//

import Foundation



protocol FlightSearchRepository {
    func search(from: String, to: String, earliest: Date) async throws -> [Flight]
}


final class FakeFlightSearchRepository: FlightSearchRepository {
    func search(from: String, to: String, earliest: Date) async throws -> [Flight] {
        try await Task.sleep(nanoseconds: 700_000_000) //

        let cal = Calendar.current
        let dates = (0..<5).compactMap { cal.date(byAdding: .day, value: $0 * 2, to: earliest) }
        let prices: [Double] = [99, 120, 150, 89, 135]

        return zip(dates, prices).map { Flight(date: $0.0, from: from, to: to, priceEUR: $0.1) }
    }
}


