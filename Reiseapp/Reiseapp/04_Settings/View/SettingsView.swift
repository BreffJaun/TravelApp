import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) private var colorScheme
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
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Persönliche Einstellungen", systemImage: "person.fill")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        VStack(spacing: 0) {
                            HStack {
                                Image(systemName: "airplane.departure")
                                    .foregroundColor(.accentColor)
                                TextField("Abreiseort", text: $abreiseOrt)
                                    .textFieldStyle(.plain)
                                    .foregroundStyle(.primary)
                            }
                            .padding()
                            Divider()
                            
                            HStack {
                                Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                                    .foregroundColor(.accentColor)
                                Toggle(isDarkModeEnabled ? "Dark Mode" : "Light Mode", isOn: $isDarkModeEnabled)
                                    .onChange(of: isDarkModeEnabled) { _, newValue in
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let window = windowScene.windows.first {
                                            window.overrideUserInterfaceStyle = newValue ? .dark : .light
                                        }
                                    }
                            }
                            .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
                            .padding()
                            Divider()
                            
                            HStack {
                                Image(systemName: "person.crop.circle.badge.checkmark")
                                    .foregroundColor(.accentColor)
                                Toggle("Senden der Benutzerdaten", isOn: $benutzerDaten)
                            }
                            .padding()
                            .foregroundStyle(.primary)
                        }
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                        
                        Text("Ihre Benutzerdaten werden anonymisiert verarbeitet, um die Qualität von TravelMate stets verbessern zu können.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                    }
                    .padding()
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Hilfe", systemImage: "questionmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            Button(action: {
                                if let url = URL(string: "https://www.google.de") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "globe")
                                    Text("Hilfe-Forum")
                                    Spacer()
                                }
                                .foregroundColor(.accentColor)
                                .padding()
                            }
                            Divider()
                            
                            Button(action: {
                                if let url = URL(string: "tel://+4912345"),
                                   UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "phone.fill")
                                    Text("Hotline")
                                    Spacer()
                                }
                                .foregroundColor(.accentColor)
                                .padding()
                            }
                        }
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                        
                        Text("Unsere Hotline erreichen Sie Mo-Mi 9:00 - 13:30")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                            .padding(.vertical)
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
