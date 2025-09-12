//
//  FlightRepository.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//

import Foundation

final class RemoteFlightRepository: FlightRepository {

    private let apiKey = APIKeys.serpAPI.rawValue
    private let baseURL = "https://serpapi.com/search"
    private var localCityToIATA: [String: String] = [:]

    init() {
        loadCityIATAFromJSON()
    }

    // ⚠️: Muss exakt zum Protokoll passen
    func searchFlights(from cityFrom: String, to cityTo: String, earliest: Date, returnDate: Date?) async throws -> [Flight] {

        guard let departureIATA = localCityToIATA[cityFrom.lowercased()],
              let destinationIATA = localCityToIATA[cityTo.lowercased()] else {
            print("⚠️ IATA-Code nicht gefunden für \(cityFrom) oder \(cityTo)")
            return []
        }

        var components = URLComponents(string: baseURL)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "engine", value: "google_flights"),
            URLQueryItem(name: "departure_id", value: departureIATA),
            URLQueryItem(name: "arrival_id", value: destinationIATA),
            URLQueryItem(name: "outbound_date", value: dateFormatter.string(from: earliest)),
            URLQueryItem(name: "gl", value: "de"),
            URLQueryItem(name: "hl", value: "de"),
            URLQueryItem(name: "type", value: "2"),
            URLQueryItem(name: "currency", value: "EUR"),
//            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        if let returnDate = returnDate {
            queryItems.append(URLQueryItem(name: "return_date", value: dateFormatter.string(from: returnDate)))
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            print("⚠️ Fehler beim Erstellen der URL")
            return []
        }

        print("🔹 Anfrage an API: \(url)")
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse {
            print("🔹 HTTP Status: \(httpResponse.statusCode), Daten: \(data.count) bytes")
        }

        let apiResponse = try JSONDecoder().decode(FlightAPIResponse.self, from: data)

        guard let bestFlights = apiResponse.best_flights, !bestFlights.isEmpty else {
            print("⚠️ Keine Flüge im API Response")
            return []
        }

        return mapToFlights(bestFlights)
    }

    private func loadCityIATAFromJSON() {
        guard let url = Bundle.main.url(forResource: "CityIATA", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([String: String].self, from: data) else {
            print("⚠️ Konnte CityIATA.json nicht laden – nutze leere Liste.")
            return
        }
        localCityToIATA = Dictionary(uniqueKeysWithValues: decoded.map { ($0.key.lowercased(), $0.value) })
        print("✅ CityIATA.json geladen mit \(localCityToIATA.count) Einträgen")
    }

    private func mapToFlights(_ bestFlights: [FlightData]) -> [Flight] {
        var flights: [Flight] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        for flightData in bestFlights {
            guard let firstLeg = flightData.flights.first,
                  let lastLeg = flightData.flights.last,
                  let departureDate = dateFormatter.date(from: firstLeg.departure_airport.time) else {
                print("⚠️ Konnte Flug nicht parsen: \(flightData)")
                continue
            }

            let flight = Flight(
                departure: firstLeg.departure_airport.id,
                destination: lastLeg.arrival_airport.id,
                date: departureDate,
                priceEUR: flightData.price
            )

            flights.append(flight)
            print("✈️ Flight: \(flight.departure) → \(flight.destination), \(flight.date), \(flight.priceEUR) EUR")
        }

        return flights
    }
}
