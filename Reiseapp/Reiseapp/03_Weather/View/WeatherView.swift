//
//  WeatherView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var vm: WeatherViewModel

    // Dependency Injection per Initializer
    init(repo: WeatherRepository) {
        _vm = StateObject(wrappedValue: WeatherViewModel(repo: repo))
    }

    var body: some View {
        GradientBackground {
            VStack(spacing: 32) {
                Spacer()

                TextField("Ort eingeben", text: $vm.city)
                    .textFieldStyle(.plain)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                    .overlay {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.white.opacity(0.25))
                    }
                    .submitLabel(.search)
                    .onSubmit { Task { await vm.loadWeather() } }
                    .padding(.horizontal, 32)

                if vm.isLoading {
                    ProgressView().tint(.white)
                } else if let info = vm.info {
                    VStack(spacing: 16) {
                        Image(systemName: info.condition.sfSymbol)
                            .font(.system(size: 110))
                            .foregroundStyle(.white)
                            .shadow(radius: 2)

                        Text("\(info.temperature, specifier: "%.1f")°C")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundStyle(.white)
                            .shadow(radius: 1)

                        Text("Luftfeuchtigkeit: \(info.humidity)%")
                            .font(.system(size: 20))
                            .foregroundStyle(.white.opacity(0.9))

                        Text("Wind: \(info.windSpeed, specifier: "%.1f") m/s")
                            .font(.system(size: 20))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .transition(.opacity.combined(with: .scale))
                } else if let err = vm.errorMessage {
                    Text(err)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                } else {
                    VStack {
                        Image(systemName: "cloud.sun")
                            .font(.system(size: 72))
                            .foregroundStyle(.white.opacity(0.9))
                        Text("Suche starten …")
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }

                Spacer()
            }
        }
    }
}
#Preview() {
    WeatherView(repo: MockWeatherRepository())
}
