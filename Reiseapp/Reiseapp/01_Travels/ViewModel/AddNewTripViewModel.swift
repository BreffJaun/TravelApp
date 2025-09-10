//
//  AddNewTripViewModel.swift
//  Reiseapp
//
//  Created by Romina Reiber on 10.09.25.
//

import Foundation
@MainActor
class AddNewTripViewModel: ObservableObject {
    @Published var titel: String = ""
    @Published var vonOrt: String = ""
    @Published var zielOrt: String = ""
    @Published var preisProPerson: Double = 0.0
    @Published var reisendePersonen: [String] = []
    @Published var neuerMitreisender: String = ""
    @Published var abreiseDatum: Date = Date()
    
    init() {
        
    }
    
    var preisGesamt: Double {
        preisProPerson * Double(reisendePersonen.count)
    }
}
