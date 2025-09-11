//
//  TripDetailView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 09.09.25.
//

import SwiftUI

struct TravelDetailView: View {
    
    @StateObject private var travelDetailViewModel: TravelDetailViewModel
    
    init(trip: Trip, weatherRepo: WeatherRepository) {
        _travelDetailViewModel = StateObject(wrappedValue: TravelDetailViewModel(trip: trip, weatherRepo: weatherRepo))
    }
    // später: @EnvironmentObject private var flightViewModel: FlightViewModel
    
    var body: some View {
        GradientBackground {
            List {
                Section {
                    Text(travelDetailViewModel.trip.destination)
                    Text(travelDetailViewModel.formattedDate)
                }
                
                Section("Wetter") {
                    if travelDetailViewModel.isLoadingWeather {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
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
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        Text("Keine Wetterdaten verfügbar")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Günstigste Flüge") {
                    Text("Flugdaten werden geladen …")
                        .foregroundColor(.secondary)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .navigationTitle(travelDetailViewModel.trip.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await travelDetailViewModel.loadWeather()
        }
    }
}


//#Preview {
//    TravelDetailView()
//}
