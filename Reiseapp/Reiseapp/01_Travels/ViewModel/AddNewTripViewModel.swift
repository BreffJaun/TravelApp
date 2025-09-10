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
    
    init(travelViewModel: TravelViewModel) {
        self.travelViewModel = travelViewModel
    }
    
    var preisGesamt: Double {
        pricePerPerson * Double(travelers.count)
    }
    
    func addNewTrip() {
        let newTrip = Trip(
            title: title,
            departure: departure,
            destination: destination,
            pricePerPerson: pricePerPerson,
            travelers: travelers,
            departureDate: departureDate,
            image: image
        )
        travelViewModel.addTrip(newTrip)
            clearFields()
        }
    
    
    func addMitreisender() {
        guard !newTraveler.isEmpty else { return }
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
}
