//
//  FlightRepository.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//

import Foundation

//struct IATAResponse: Codable {
//    struct Entry: Codable {
//        let iata: String
//        let fs: String?
//        let name: String
//    }
//    let data: [Entry]
//}

//final class RemoteFlightRepository: FlightRepository {
//    
//    private let baseURL = "https://api.flightapi.io/onewaytrip"
//    
//    private var localCityToIATA: [String: String] = [:]
//    
//    init() {
//        loadCityIATAFromJSON()
//    }
//    
//    private func loadCityIATAFromJSON() {
//        guard let url = Bundle.main.url(forResource: "CityIATA", withExtension: "json"),
//              let data = try? Data(contentsOf: url),
//              let decoded = try? JSONDecoder().decode([String: String].self, from: data)
//        else {
//            print("⚠️ Konnte CityIATA.json nicht laden – nutze leere Liste.")
//            return
//        }
//        
//        localCityToIATA = decoded
//        print("✅ CityIATA.json geladen mit \(localCityToIATA.count) Einträgen")
//    }
//    
//    func searchFlights(from cityFrom: String, to cityTo: String, earliest: Date) async throws -> [Flight] {
//        print("🌐 RemoteFlightRepository.searchFlights() called – fetching real data")
//        
//        // 1️⃣ IATA Codes auflösen
//        async let fromIATA = fetchIATACode(for: cityFrom)
//        async let toIATA = fetchIATACode(for: cityTo)
//        
//        guard let fromCode = try await fromIATA,
//              let toCode = try await toIATA else {
//            print("⚠️ Konnte IATA Code nicht auflösen – Abbruch.")
//            throw FlightAPIError.invalidRequest
//        }
//        print("🔹 Resolved IATA: \(cityFrom) → \(fromCode), \(cityTo) → \(toCode)")
//        
//        // 2️⃣ Datum formatieren
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let dateStr = formatter.string(from: earliest)
//        
//        // 3️⃣ Flight API URL bauen
//        let urlString = "\(baseURL)/\(APIKeys.flightAPI.rawValue)/\(fromCode)/\(toCode)/\(dateStr)/1/0/0/Economy/EUR"
//        guard let url = URL(string: urlString) else { throw FlightAPIError.invalidRequest }
//        print("🔹 Flight API URL: \(url.absoluteString)")
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        // 4️⃣ Daten abrufen
//        let (data, response) = try await URLSession.shared.data(for: request)
//        if let http = response as? HTTPURLResponse {
//            print("🔹 HTTP Response Code: \(http.statusCode)")
//            if http.statusCode != 200 {
//                print("⚠️ API lieferte Status \(http.statusCode) – keine Flugdaten.")
//                throw FlightAPIError.invalidResponse
//            }
//        }
//        if let raw = String(data: data, encoding: .utf8) {
//            print("🔹 Flight API Raw Response: \(raw)")
//        }
//        
//        // 5️⃣ FlightAPI Response decodieren
//        do {
//            let decoded = try JSONDecoder().decode(FlightAPIResponse.self, from: data)
//            return parseFlights(from: decoded)
//        } catch {
//            print("⚠️ Decoding error: \(error)")
//            print("⚠️ Error details: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
//            throw error
//        }
//    }
//    
//    private func parseFlights(from response: FlightAPIResponse) -> [Flight] {
//        var flights: [Flight] = []
//        
//        // Place-Mapping erstellen
//        let placeDict = Dictionary(uniqueKeysWithValues: response.places.map { ($0.id, $0.display_code) })
//        
//        // DateFormatter für das API-Datumformat
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        
//        for itinerary in response.itineraries {
//            // Preis aus der ersten Pricing-Option holen (mit sicherer Optional-Handling)
//            var price: Double = 0
//            if let firstPricingOption = itinerary.pricing_options.first,
//               let priceObj = firstPricingOption.price,
//               let amount = priceObj.amount {
//                price = amount
//            }
//            
//            for legID in itinerary.leg_ids {
//                guard let leg = response.legs[legID],
//                      let dateStr = leg.date,
//                      let depDate = dateFormatter.date(from: dateStr),
//                      let originID = leg.origin,
//                      let destinationID = leg.destination,
//                      let depCode = placeDict[originID],
//                      let arrCode = placeDict[destinationID] else {
//                    continue
//                }
//                
//                let flight = Flight(
//                    departure: depCode,
//                    destination: arrCode,
//                    date: depDate,
//                    priceEUR: price
//                )
//                flights.append(flight)
//            }
//        }
//        
//        print("🔹 Total flights returned: \(flights.count)")
//        return flights
//    }
//    
//
//    
//    // MARK: - IATA Codes abrufen
//    private func fetchIATACode(for city: String) async throws -> String? {
//        let key = city.lowercased()
//        if let code = localCityToIATA[key] {
//            print("🔹 Using local mapping for \(city): \(code)")
//            return code
//        }
//        
//        // Fallback: API-Anfrage, wenn nicht in JSON
//        let urlString = "https://api.flightapi.io/iata/\(APIKeys.flightAPI.rawValue)?name=\(city)&type=airport"
//        guard let url = URL(string: urlString) else { return nil }
//        
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let decoded = try JSONDecoder().decode(IATAResponse.self, from: data)
//        
//        if let exactMatch = decoded.data.first(where: { !$0.iata.isEmpty }) {
//            print("🔹 Fetched IATA for \(city): \(exactMatch.iata)")
//            return exactMatch.iata
//        }
//        
//        print("⚠️ No valid IATA code found for \(city)")
//        return nil
//    }
//}

import Foundation


//class RemoteFlightRepository: FlightRepository {
//
//    private let apiKey = APIKeys.serpAPI.rawValue
//    private let baseURL = "https://api.serpapi.com/flights"
//
//    private var localCityToIATA: [String: String] = [:]
//
//    init() {
//        loadCityIATAFromJSON()
//    }
//
//    // MARK: - FlightRepository Methode
//    func searchFlights(from cityFrom: String, to cityTo: String, earliest: Date) async throws -> [Flight] {
//        
//        // Case-insensitive Lookup
//        guard let departureIATA = localCityToIATA[cityFrom.lowercased()],
//              let destinationIATA = localCityToIATA[cityTo.lowercased()] else {
//            print("IATA-Code nicht gefunden für \(cityFrom) oder \(cityTo)")
//            return []
//        }
//
//        var components = URLComponents(string: baseURL)!
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        components.queryItems = [
//            URLQueryItem(name: "api_key", value: apiKey),
//            URLQueryItem(name: "origin", value: departureIATA),
//            URLQueryItem(name: "destination", value: destinationIATA),
//            URLQueryItem(name: "date", value: dateFormatter.string(from: earliest))
//        ]
//
//        guard let url = components.url else { return [] }
//
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let apiResponse = try JSONDecoder().decode(FlightAPIResponse.self, from: data)
//
//        return mapToFlights(apiResponse: apiResponse, departureCity: cityFrom, destinationCity: cityTo)
//    }
//
//    // MARK: - JSON Loader für IATA Codes
//    private func loadCityIATAFromJSON() {
//        guard let url = Bundle.main.url(forResource: "CityIATA", withExtension: "json"),
//              let data = try? Data(contentsOf: url),
//              let decoded = try? JSONDecoder().decode([String: String].self, from: data)
//        else {
//            print("⚠️ Konnte CityIATA.json nicht laden – nutze leere Liste.")
//            return
//        }
//
//        // Keys auf lowercase normalisieren für case-insensitive Lookup
//        localCityToIATA = Dictionary(uniqueKeysWithValues: decoded.map { ($0.key.lowercased(), $0.value) })
//        print("✅ CityIATA.json geladen mit \(localCityToIATA.count) Einträgen")
//    }
//
//    // MARK: - Mapping von API Response zu Flight
//    private func mapToFlights(apiResponse: FlightAPIResponse, departureCity: String, destinationCity: String) -> [Flight] {
//        var flights: [Flight] = []
//
//        for itinerary in apiResponse.itineraries {
//            // Preis direkt verwenden (nicht optional)
//            guard let price = itinerary.pricing_options.first?.price.amount else { continue }
//
//            // Datum aus dem ersten Leg
//            guard let firstLegId = itinerary.leg_ids.first,
//                  let leg = apiResponse.legs[firstLegId] else {
//                continue
//            }
//
//            let dateStr = leg.date
//            let date = ISO8601DateFormatter().date(from: dateStr) ?? Date()  // Falls Parsing fehlschlägt, heutiges Datum nehmen
//
//            let flight = Flight(
//                departure: departureCity,
//                destination: destinationCity,
//                date: date,
//                priceEUR: price
//            )
//            flights.append(flight)
//        }
//
//        return flights
//    }
//}

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
