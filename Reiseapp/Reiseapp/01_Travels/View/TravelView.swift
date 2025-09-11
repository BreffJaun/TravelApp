//
//  TravelView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct TravelView: View {
    
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    @EnvironmentObject private var travelViewModel: TravelViewModel
    @EnvironmentObject private var travelDetailViewModel: TravelDetailViewModel
    @State private var selectedTrip: Trip?
    @State private var showAddNewTripSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            GradientBackground{
                List {
                    ForEach(travelViewModel.trips) { trip in
                        TravelListItemView(trip: trip)
                            .onTapGesture {
                                selectedTrip = trip
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .navigationDestination(item: $selectedTrip) { trip in
                    TravelDetailView(trip: trip, weatherRepo: weatherViewModel.repo)
                }
            }
            .navigationTitle("Meine Reisen")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddNewTripSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddNewTripSheet) {
                AddNewTripSheet(travelViewModel: travelViewModel)
            }
        }
    }
}

//#Preview {
//    TravelView()
//}

