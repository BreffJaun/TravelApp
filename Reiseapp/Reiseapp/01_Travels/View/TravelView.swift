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
                        Color("PrimaryGradientStart"),
                        Color("PrimaryGradientEnd")
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
