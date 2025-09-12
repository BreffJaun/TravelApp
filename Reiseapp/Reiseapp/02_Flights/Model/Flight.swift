//
//  Flight.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//
import Foundation

// MARK: - Flight
struct Flight: Identifiable {
    let id = UUID()
    let departure: String
    let destination: String
    let date: Date
    let priceEUR: Double
}

struct FlightAPIResponse: Codable {
    let best_flights: [FlightData]?
    let search_metadata: SearchMetadata?
}

struct SearchMetadata: Codable {
    let status: String?
    let error: String?
}

struct FlightData: Codable {
    let flights: [Leg]
    let layovers: [Layover]?
    let total_duration: Int
    let carbon_emissions: CarbonEmissions?
    let price: Double
    let type: String
    let airline_logo: String?
    let booking_token: String?
}

struct Leg: Codable {
    let departure_airport: Airport
    let arrival_airport: Airport
    let duration: Int
    let airplane: String?
    let airline: String
    let airline_logo: String?
    let travel_class: String?
    let flight_number: String?
    let legroom: String?
    let extensions: [String]?
}

struct Airport: Codable {
    let name: String
    let id: String
    let time: String
}

struct Layover: Codable {
    let duration: Int
    let name: String
    let id: String
}

struct CarbonEmissions: Codable {
    let this_flight: Int
    let typical_for_this_route: Int
    let difference_percent: Int
}
