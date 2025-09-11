//
//  travels.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

import Foundation
var dummyTrips = [
    Trip(
        title: "Malle ist nur 1 Mal im Jahr",
        departure: "Frankfurt",
        destination: "Mallorca",
        pricePerPerson: 350.0,
        travelers: ["Max", "Anna"],
        departureDate: Date(),
        image: nil
    ),
    Trip(
        title: "Familienurlaub",
        departure: "München",
        destination: "Kroatien",
        pricePerPerson: 280.0,
        travelers: ["Familie Müller"],
        departureDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Skifahrt",
        departure: "Stuttgart",
        destination: "Zillertal",
        pricePerPerson: 420.0,
        travelers: ["Tom", "Lisa", "Ben"],
        departureDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Städtereise",
        departure: "Berlin",
        destination: "Barcelona",
        pricePerPerson: 180.0,
        travelers: ["Sarah"],
        departureDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Wellness Wochenende",
        departure: "Köln",
        destination: "Baden-Baden",
        pricePerPerson: 220.0,
        travelers: ["Maria", "Klaus"],
        departureDate: Calendar.current.date(byAdding: .weekOfYear, value: 2, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Campingtrip",
        departure: "Hamburg",
        destination: "Schwarzwald",
        pricePerPerson: 90.0,
        travelers: ["Alex", "Jenny"],
        departureDate: Calendar.current.date(byAdding: .month, value: 2, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Roadtrip",
        departure: "Dresden",
        destination: "Italien",
        pricePerPerson: 310.0,
        travelers: ["Marco", "Elena"],
        departureDate: Calendar.current.date(byAdding: .month, value: 3, to: Date())!,
        image: nil
    )
]










