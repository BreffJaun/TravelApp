//
//  AddNewTripViewModel.swift
//  Reiseapp
//
//  Created by Romina Reiber on 10.09.25.
//

import Foundation
import SwiftUI

@MainActor
class AddNewTripViewModel: ObservableObject {

    @Published var title: String = ""
    @Published var departure: String = ""
    @Published var destination: String = ""
    @Published var pricePerPerson: Double = 0.0
    @Published var newTraveler: String = ""
    @Published var travelers: [String] = []
    @Published var departureDate: Date = Date()
    @Published var image: UIImage? = nil

    private let travelViewModel: TravelViewModel
    private let trip: Trip?   // optional

    init(travelViewModel: TravelViewModel, trip: Trip? = nil) {
        self.travelViewModel = travelViewModel
        self.trip = trip

        // Wenn ein Trip übergeben wurde -> Werte vorbefüllen
        if let trip {
            self.title = trip.title
            self.departure = trip.departure
            self.destination = trip.destination
            self.pricePerPerson = trip.pricePerPerson
            self.travelers = trip.travelers
            self.departureDate = trip.departureDate
            self.image = trip.image
        }
    }

    var totalPrice: Double { pricePerPerson * Double(max(1, travelers.count)) }

    func addNewTrip() {
        // Wenn trip != nil -> update, sonst hinzufügen
        if let existingTrip = trip {
            travelViewModel.updateTrip(
                existingTrip,
                title: title,
                departure: departure,
                destination: destination,
                pricePerPerson: pricePerPerson,
                travelers: travelers,
                departureDate: departureDate,
                image: image
            )
        } else {
            let newTrip = Trip(
                title: title,
                departure: departure,
                destination: destination,
                pricePerPerson: pricePerPerson,
                travelers: travelers,
                departureDate: departureDate
            )
            var tripWithImage = newTrip
            tripWithImage.image = image
            travelViewModel.addTrip(tripWithImage)
            clearFields()
        }
    }

    func addTraveler() {
        guard !newTraveler.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        travelers.append(newTraveler)
        newTraveler = ""
    }

    func clearFields() {
        title = ""
        departure = ""
        destination = ""
        pricePerPerson = 0.0
        newTraveler = ""
        travelers = []
        departureDate = Date()
        image = nil
    }

    func updateTrip() {
        guard let existing = trip else { return }
        travelViewModel.updateTrip(
            existing,
            title: title,
            departure: departure,
            destination: destination,
            pricePerPerson: pricePerPerson,
            travelers: travelers,
            departureDate: departureDate,
            image: image
        )
    }
}
