//
// WeatherView.swift
// Reiseapp
//
// Created by Jeff Braun on 08.09.25.
//
import SwiftUI
struct WeatherView: View {
  @EnvironmentObject var viewModel: WeatherViewModel
  var body: some View {
    GradientBackground {
      VStack {
        VStack {
          ZStack(alignment: .trailing) {
            TextField("Ort eingeben", text: $viewModel.city)
              .textFieldStyle(.plain)
              .padding(.horizontal, 14)
              .padding(.vertical, 12)
              .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
              .overlay {
                RoundedRectangle(cornerRadius: 14)
                  .stroke(.white.opacity(0.25))
              }
              .font(.title2)
              .submitLabel(.search)
              .onSubmit { Task { await viewModel.loadWeather() } }
              .padding(.horizontal, 32)
            if !viewModel.city.isEmpty {
              Button {
                viewModel.city = ""
              } label: {
                Image(systemName: "xmark.circle.fill")
                  .imageScale(.medium)
                  .foregroundStyle(.white.opacity(0.75))
                  .padding(.trailing, 40)
                  .padding(.vertical, 6)
              }
              .accessibilityLabel("Eingabe löschen")
            }
          }
        }
        .padding(.top, 60)
        Spacer()
        Group {
          if viewModel.isLoading {
            ProgressView().tint(.white)
          } else if let info = viewModel.info {
            VStack(spacing: 16) {
              Image(systemName: info.condition.sfSymbol)
                .font(.system(size: 220))
                .foregroundStyle(.white)
                .shadow(radius: 2)
              Text("\(info.temperature, specifier: "%.1f")°C")
                .font(.system(size: 100, weight: .bold))
                .foregroundStyle(.white)
                .shadow(radius: 1)
              Text("Luftfeuchtigkeit: \(info.humidity)%")
                .font(.title2)
                .bold()
                .foregroundStyle(.white.opacity(0.9))
              Text("Wind: \(info.windSpeed, specifier: "%.1f") m/s")
                .font(.title2)
                .bold()
                .foregroundStyle(.white.opacity(0.9))
            }
            .transition(.opacity.combined(with: .scale))
          } else if let err = viewModel.errorMessage {
            Text(err)
              .foregroundStyle(.white)
              .font(.system(size: 28, weight: .bold))
              .padding(.horizontal)
              .multilineTextAlignment(.center)
          } else {
            VStack {
              Image(systemName: "cloud.sun")
                .font(.system(size: 220))
                .foregroundStyle(.white.opacity(0.9))
              Text("Suche starten …")
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(.white.opacity(0.9))
            }
          }
        }
        Spacer()
      }
      .ignoresSafeArea(edges: .bottom)
    }
  }
}
#Preview() {
  WeatherView()
}
