//
//  TripDetailView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 09.09.25.
//

import SwiftUI

struct TravelDetailView: View {
    
    var trip: Trip
    
    var body: some View {
        Text(trip.title)
    }
}

//#Preview {
//    TravelDetailView()
//}
