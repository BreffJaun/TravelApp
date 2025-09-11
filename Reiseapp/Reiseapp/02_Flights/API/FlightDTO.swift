//
//  FlightDTO.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 10.09.25.
//

import Foundation


struct FlightSearchResponseDTO: Decodable {
    let flights: [FlightDTO]
}
struct FlightDTO: Decodable {
    let from: String
    let to: String
    let date: String
    let price: Double
}
