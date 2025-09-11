//
//  TravelViewModel.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

import SwiftUI

@MainActor
class TravelViewModel: ObservableObject {
    
    @Published var trips: [Trip] = dummyTrips
    
<<<<<<< HEAD
=======
    // MARK: - METHODS
    
>>>>>>> main
    func addTrip(_ trip: Trip) -> Bool {
        guard canAddTrip(trip: trip) else { return false }
        trips.append(trip)
        return true
    }

    func canAddTrip(trip: Trip) -> Bool {
        !trip.title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !trip.departure.trimmingCharacters(in: .whitespaces).isEmpty &&
        !trip.destination.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func deleteTrip(trip: Trip) {
        trips.removeAll { $0.id == trip.id }
    }
    
    func updateTrip(
        _ trip: Trip,
        title: String,
        departure: String,
        destination: String,
        pricePerPerson: Double,
        travelers: [String],
        departureDate: Date,
        image: UIImage? = nil
    ) {
        guard let index = trips.firstIndex(where: { $0.id == trip.id }) else { return }
        
        trips[index] = Trip(
<<<<<<< HEAD
            id: trip.id,
=======
            id: trip.id, // wichtig, damit die ID gleich bleibt
>>>>>>> main
            title: title,
            departure: departure,
            destination: destination,
            pricePerPerson: pricePerPerson,
            travelers: travelers,
            departureDate: departureDate,
            image: image
        )
    }
    
    func tripsSortedByTitle() -> [Trip] {
        trips.sorted { $0.title < $1.title }
    }
}
