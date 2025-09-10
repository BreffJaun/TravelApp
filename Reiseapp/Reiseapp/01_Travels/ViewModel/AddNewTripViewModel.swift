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
    @Published var vonOrt: String = ""
    @Published var zielOrt: String = ""
    @Published var preisProPerson: Double = 0.0
    @Published var neuerMitreisender: String = ""
    @Published var reisendePersonen: [String] = []
    @Published var abreiseDatum: Date = Date()
    @Published var selectedImage: UIImage? = nil
    
    @Published private(set) var newTrips: [NewTrip] = []
    
    var preisGesamt: Double {
        preisProPerson * Double(reisendePersonen.count)
    }
    
    func addNewTrip() {
        let trip = NewTrip(
            title: title,
            vonOrt: vonOrt,
            zielOrt: zielOrt,
            preisProPerson: preisProPerson,
            reisendePersonen: reisendePersonen,
            abreiseDatum: abreiseDatum,
            image: selectedImage
        )
        newTrips.append(trip)
        clearFields()
    }
    
    func addMitreisender() {
        guard !neuerMitreisender.isEmpty else { return }
        reisendePersonen.append(neuerMitreisender)
        neuerMitreisender = ""
    }
    
    func clearFields() {
        title = ""
        vonOrt = ""
        zielOrt = ""
        preisProPerson = 0.0
        neuerMitreisender = ""
        reisendePersonen = []
        abreiseDatum = Date()
        selectedImage = nil
    }
}
