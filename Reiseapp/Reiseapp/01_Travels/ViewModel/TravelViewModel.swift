//
//  TravelViewModel.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation
import SwiftUI
import UIKit

@MainActor
class TravelViewModel: ObservableObject {

    @AppStorage("savedTrips") private var tripsData: Data = Data()

    @Published var trips: [Trip] = dummyTrips

    init() {
        loadTrips()
    }

    private func saveTrips() {
        do {
            let encoded = try JSONEncoder().encode(trips)
            tripsData = encoded
        } catch {
            print("TravelViewModel: Failed to encode trips:", error)
        }
    }

    private func loadTrips() {
        guard !tripsData.isEmpty else {
            trips = dummyTrips
            return
        }

        do {
            let decoded = try JSONDecoder().decode([Trip].self, from: tripsData)
            trips = decoded
        } catch {
            print("TravelViewModel: Failed to decode trips:", error)
            trips = dummyTrips
        }
    }

    func addTrip(_ trip: Trip) -> Bool {
        guard canAddTrip(trip: trip) else { return false }
        trips.append(trip)
        saveTrips()
        return true
    }

    func canAddTrip(trip: Trip) -> Bool {
        !trip.title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !trip.departure.trimmingCharacters(in: .whitespaces).isEmpty &&
        !trip.destination.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func deleteTrip(trip: Trip) {
        trips.removeAll { $0.id == trip.id }
        saveTrips()
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

        var updatedTrip = Trip(
            id: trip.id,
            title: title,
            departure: departure,
            destination: destination,
            pricePerPerson: pricePerPerson,
            travelers: travelers,
            departureDate: departureDate
        )
        updatedTrip.image = image

        trips[index] = updatedTrip
        saveTrips()
    }

    func tripsSortedByTitle() -> [Trip] {
        trips.sorted { $0.title < $1.title }
    }
}
