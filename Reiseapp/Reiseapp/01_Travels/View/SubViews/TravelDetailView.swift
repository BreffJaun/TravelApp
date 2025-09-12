//
//  TripDetailView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 09.09.25.
//

import SwiftUI

struct TravelDetailView: View {
    
    @EnvironmentObject private var travelViewModel: TravelViewModel
    @EnvironmentObject private var flightViewModel: FlightViewModel
    @StateObject private var travelDetailViewModel: TravelDetailViewModel
    
    @State private var showEditSheet: Bool = false
    let trip: Trip

    
    init(trip: Trip, weatherRepo: WeatherRepository) {
        _travelDetailViewModel = StateObject(
            wrappedValue: TravelDetailViewModel(
                trip: trip,
                weatherRepo: weatherRepo
            )
        )
        self.trip = trip
    }
    
    var body: some View {
        GradientBackground {
            List {
                Section {
                    Text(travelDetailViewModel.trip.destination)
                    Text(travelDetailViewModel.formattedDate)
                }
                
                Section("Wetter") {
                    if travelDetailViewModel.isLoadingWeather {
                        HStack { Spacer(); ProgressView(); Spacer() }
                    } else if let info = travelDetailViewModel.weatherInfo {
                        HStack {
                            Image(systemName: info.condition.sfSymbol)
                                .foregroundColor(info.condition.iconColor)
                            Spacer()
                            Text("\(info.temperature, specifier: "%.1f")°C")
                                .foregroundColor(info.condition.tempColor(for: info.temperature))
                        }
                        .padding(.vertical, 4)
                    } else if let error = travelDetailViewModel.weatherError {
                        Text(error).foregroundColor(.red)
                    } else {
                        Text("Keine Wetterdaten verfügbar").foregroundColor(.secondary)
                    }
                }
                
                Section("Günstigste Flüge") {
                    if travelDetailViewModel.isLoadingFlights {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else if let error = travelDetailViewModel.flightError {
                        Text(error)
                            .foregroundColor(.red)
                    } else if travelDetailViewModel.flights.isEmpty {
                        Text("Keine Flüge gefunden")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(travelDetailViewModel.flights) { flight in
                            FlightListItemView(flight: flight)
                                .listRowInsets(EdgeInsets())
                                .padding(.vertical, 8)
                                .listRowSeparator(.hidden)
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .navigationTitle(travelDetailViewModel.trip.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            travelDetailViewModel.configure(with: travelViewModel)
            await travelDetailViewModel.loadWeather()
            await travelDetailViewModel.loadFlights()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Bearbeiten") { showEditSheet = true }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            EditTripSheet(travelViewModel: travelViewModel, trip: trip)
        }
    }
}



//#Preview {
//    TravelDetailView()
//}
