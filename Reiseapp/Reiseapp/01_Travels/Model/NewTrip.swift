//
//  NewTrip.swift
//  Reiseapp
//
//  Created by Romina Reiber on 10.09.25.
//

import Foundation

import Foundation
import UIKit

struct NewTrip: Hashable {
    var title: String
    var vonOrt: String
    var zielOrt: String
    var preisProPerson: Double
    var reisendePersonen: [String]
    var abreiseDatum: Date
    var image: UIImage? = nil
}
