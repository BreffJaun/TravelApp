//
//  ContentView.swift
//  Projektwoche1
//
//  Created by Jana Jansen on 24.01.25.
//

import SwiftUI
import SwiftData
import UIKit

struct TabBarView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init() {
        UITabBar.appearance().tintColor = UIColor(named: "IconAccent")
    }

    
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
