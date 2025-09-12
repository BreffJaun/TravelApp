//
//  FlightView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//
// 02_Flights/View/FlightView.swift

import SwiftUI

struct FlightView: View {
    
    @EnvironmentObject private var flightViewModel: FlightViewModel
    
    var body: some View {
        NavigationStack {
            GradientBackground {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        InputField(title: "Startort", text: $flightViewModel.departureCity)
                        InputField(title: "Zielort", text: $flightViewModel.destinationCity)
                        
                        HStack {
                            Text("Ergebnisse ab dem")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            DatePicker("", selection: $flightViewModel.departureDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 48)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        
                        Button {
                            flightViewModel.search()
                        } label: {
                            Label("Suchen", systemImage: "magnifyingglass")
                                .frame(maxWidth: .infinity, minHeight: 32)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
                    }
                    
                    if let msg = flightViewModel.errorMessage {
                        Text(msg)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                    }
                    if flightViewModel.isLoading {
                        ProgressView("Suche läuft…")
                            .padding(.top, 8)
                    }
                    
                    if !flightViewModel.results.isEmpty {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(flightViewModel.results) { flight in
                                    FlightListItemView(flight: flight)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                    Spacer(minLength: 8)
                }
            }
            .navigationTitle("Günstigste Flüge")
        }
    }
}

//#Preview {
//    FlightView()
//}
