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
    
    let trip: Trip
    private(set) var travelViewModel: TravelViewModel!  
    
    private let weatherRepo: WeatherRepository
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        return f
    }()
    
    init(trip: Trip, weatherRepo: WeatherRepository) {
        self.trip = trip
        self.weatherRepo = weatherRepo
        self.formattedDate = dateFormatter.string(from: trip.departureDate)
    }
    
    /// Wird nach Init von außen aufgerufen, sobald EnvironmentObject verfügbar ist
    func configure(with travelViewModel: TravelViewModel) {
        self.travelViewModel = travelViewModel
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
}
