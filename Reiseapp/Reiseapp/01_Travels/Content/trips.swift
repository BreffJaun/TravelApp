//
//  travels.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

var dummyTrips = [
    Trip(
        title: "Familienurlaub",
        departure: "München",
        destination: "Paris",
        pricePerPerson: 280.0,
        travelers: ["Familie Müller"],
        departureDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Skifahrt",
        departure: "Stuttgart",
        destination: "Stockholm",
        pricePerPerson: 420.0,
        travelers: ["Tom", "Lisa", "Ben"],
        departureDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Städtereise",
        departure: "Berlin",
        destination: "London",
        pricePerPerson: 180.0,
        travelers: ["Sarah"],
        departureDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Wellness Wochenende",
        departure: "Köln",
        destination: "Amsterdam",
        pricePerPerson: 220.0,
        travelers: ["Maria", "Klaus"],
        departureDate: Calendar.current.date(byAdding: .weekOfYear, value: 2, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Campingtrip",
        departure: "Hamburg",
        destination: "Helsinki",
        pricePerPerson: 90.0,
        travelers: ["Alex", "Jenny"],
        departureDate: Calendar.current.date(byAdding: .month, value: 2, to: Date())!,
        image: nil
    ),
    Trip(
        title: "Roadtrip",
        departure: "Dresden",
        destination: "Paris",
        pricePerPerson: 310.0,
        travelers: ["Marco", "Elena"],
        departureDate: Calendar.current.date(byAdding: .month, value: 3, to: Date())!,
        image: nil
    )
]









