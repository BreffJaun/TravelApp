//
//  Flight.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//
import Foundation

struct Flight: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let from: String
    let to: String
    let priceEUR: Double
}
