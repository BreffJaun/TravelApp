//
//  TravelView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct TravelView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.65, green: 0.85, blue: 1.0),
                        Color(red: 0.45, green: 0.75, blue: 0.95),
                        Color(red: 0.60, green: 0.55, blue: 0.90)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                // HIER KOMMT IMMER ALLES REIN! LINEAR GRADIENT BEI ALLEN SEITEN ALS BACKGROUND
                VStack {
                    Text("TRAVEL VIEW")
                }
            }
        }
    }
}

#Preview {
    TravelView()
}
