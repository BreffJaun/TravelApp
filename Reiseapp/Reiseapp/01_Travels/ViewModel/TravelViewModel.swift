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
    
    @Published private(set) var trips: [Trip] = dummyTrips
    
    
    // METHODS
    func addTrip(title: String, destination: String, imageName: String? = nil) -> Bool {
        guard canAddTrip(title: title, destination: destination) else { return false }
        let newTrip = Trip(title: title, destination: destination, imageName: imageName)
        trips.append(newTrip)
        return true
    }
    
    func canAddTrip(title: String, destination: String) -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !destination.trimmingCharacters(in: .whitespaces).isEmpty
    }
        
    func deleteTrip(trip: Trip) {
        trips.removeAll { $0.id == trip.id }
    }
    
    func updateTrip(_ trip: Trip, title: String, destination: String, imageName: String? = nil) {
        guard let index = trips.firstIndex(where: { $0.id == trip.id }) else { return }
        trips[index] = Trip(title: title, destination: destination, imageName: imageName)
    }
        
    func tripsSortByTitle(sortedByTitle: Bool = false) -> [Trip] {
        if sortedByTitle {
            return trips.sorted { $0.title < $1.title }
        } else {
            return trips
        }
    }
}
