//
//  FlightListItemView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 11.09.25.
//

import SwiftUI

struct FlightListItemView: View {
    let flight: Flight

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(flight.departure) → \(flight.destination)")
                    .font(.headline)
                Text(flight.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(String(format: "%.2f €", flight.priceEUR))
                .font(.headline)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("SecondaryGradientStart"),
                    Color("SecondaryGradientEnd")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}



//#Preview {
//    FlightListItemView()
//}


