//
//  TravelDetailViewModel.swift
//  Reiseapp
//
//  Created by Jeff Braun on 11.09.25.
//

import Foundation

@MainActor
final class TravelDetailViewModel: ObservableObject {
    @Published var formattedDate: String
    @Published var isLoadingWeather = false
    @Published var weatherInfo: WeatherInfo?
    @Published var weatherError: String?
    
    @Published var flights: [Flight] = []
    @Published var isLoadingFlights = false
    @Published var flightError: String?
    
    
    let trip: Trip
    
    private let weatherRepo: WeatherRepository
    private let flightRepo: FlightRepository
    
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        return f
    }()
    
    init(trip: Trip, weatherRepo: WeatherRepository, flightRepo: FlightRepository = RemoteFlightRepository()) {
        self.trip = trip
        self.weatherRepo = weatherRepo
        self.flightRepo = flightRepo
        self.formattedDate = dateFormatter.string(from: trip.departureDate)
    }
    
    func loadWeather() async {
        isLoadingWeather = true
        weatherError = nil
        defer { isLoadingWeather = false }
        
        do {
            weatherInfo = try await weatherRepo.fetchWeather(for: trip.destination)
        } catch {
            weatherInfo = nil
            weatherError = error.localizedDescription
        }
    }
    
    func loadFlights() async {
        isLoadingFlights = true
        flightError = nil
        defer { isLoadingFlights = false }
        
        do {
            let results = try await flightRepo.searchFlights(
                from: trip.departure,
                to: trip.destination,
                earliest: trip.departureDate,
                returnDate: nil
            )
            flights = Array(results.prefix(10)) // max. 10 anzeigen
        } catch {
            flightError = error.localizedDescription
        }
    }
}
