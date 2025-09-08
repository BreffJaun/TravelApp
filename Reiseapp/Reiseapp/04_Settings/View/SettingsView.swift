//
//  SettingsView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var context
    
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    @State private var abreiseOrt: String = ""
    @State private var benutzerDaten: Bool = false
  
    
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
                VStack {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Persönliche Einstellungen")
                    }
                    List {
                        Section {
                            TextField("Abreiseort", text: $abreiseOrt)
                                .padding(12)
                                .background(.white.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .padding(.horizontal)
                            HStack {
                                Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                                    .foregroundColor(.primary)
                                Toggle(isDarkModeEnabled ? "Dark Mode" : "Light Mode", isOn: $isDarkModeEnabled)
                                    .onChange(of: isDarkModeEnabled) { _, newValue in
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let window = windowScene.windows.first {
                                            window.overrideUserInterfaceStyle = newValue ? .dark : .light
                                        }
                                    }
                            }
                            .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
                            .padding(12)
                            .background(.white.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .padding(.horizontal)
                            
                            Toggle("Senden der Benutzerdaten", isOn: $benutzerDaten)
                                .padding(12)
                                .background(.white.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .padding(.horizontal)
                            Text("Ihre Benutzerdaten werden anonymisiert verarbeitet, um die Qualität von TravelMate stets verbessern zu können.")
                                .font(.caption)
                                .padding(.horizontal)
                                .foregroundStyle(.opacity(0.7))
                            
                            Section {
                                HStack {
                                    Image(systemName: "questionmark.circle.fill")
                                    Text("Hilfe")
                                }
                                HStack {
                                    NavigationLink {
                                        
                                    } label: {
                                        Image(systemName: "globe")
                                        Text("Hilfe-Forum")
                                    }
                                }
                                HStack {
                                    NavigationLink {
                                        
                                    } label: {
                                        Image(systemName: "phone.fill")
                                        Text("Hotline")
                                    }
                                }
                                Text("Unsere Hotline erreichen Sie Mo-Mi 9:00 - 13:30")
                                    .font(.caption)
                                    .padding(.horizontal)
                                    .foregroundStyle(.opacity(0.7))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Einstellungen")
        }
    }
}

#Preview {
    SettingsView()
}
