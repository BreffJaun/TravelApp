//
//  ContentView.swift
//  Projektwoche1
//
//  Created by Jana Jansen on 24.01.25.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
        
    var body: some View {
        TabView {
            Tab("Reisen", systemImage: "suitcase.fill") {
                TravelView()
            }
            
            Tab("Flüge", systemImage: "airplane") {
                FlightView()
            }
            
            Tab("Wetter", systemImage: "cloud.sun") {
                WeatherView()
            }
            
            Tab("Einstellungen", systemImage: "gear") {
                SettingsView()
            }
        }
        .tint(Color("AccentColor"))
    }
}
    

#Preview {
    TabBarView()
}
