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
        try await Task.sleep(nanoseconds: 700_000_000)

        let cal = Calendar.current
        let dates = (0..<5).compactMap { cal.date(byAdding: .day, value: $0 * 2, to: earliest) }
        let prices: [Double] = [99, 120, 150, 89, 135]

        return zip(dates, prices).map { Flight(date: $0.0, from: from, to: to, priceEUR: $0.1) }
    }
}




final class RemoteFlightSearchRepository: FlightSearchRepository {
    func search(from: String, to: String, earliest: Date) async throws -> [Flight] {
        // Request 
        guard let request = FlightAPI.makeSearchRequest(from: from, to: to, date: earliest) else {
            throw FlightAPIError.invalidRequest
        }

       
        let (data, response) = try await URLSession.shared.data(for: request)

  
        guard let http = response as? HTTPURLResponse else { throw FlightAPIError.unknown }
        switch http.statusCode {
        case 200...299: break
        case 400: throw FlightAPIError.invalidRequest
        case 500...599: throw FlightAPIError.server
        default: throw FlightAPIError.unknown
        }

     
        do {
            let decoder = JSONDecoder()
            let dto = try decoder.decode(FlightSearchResponseDTO.self, from: data)

           
            let df = DateFormatter()
            df.locale = Locale(identifier: "en_US_POSIX")
            df.dateFormat = "yyyy-MM-dd"

            return dto.flights.compactMap { item in
                guard let d = df.date(from: item.date) else { return nil }
                return Flight(date: d, from: item.from, to: item.to, priceEUR: item.price)
            }
        } catch {
            throw FlightAPIError.decoding
        }
    }
}
